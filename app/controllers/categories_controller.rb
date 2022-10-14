class CategoriesController < ApplicationController
    before_action :authenticate_user!, except: %i[index show search]

    def index
        @categories = Category.all.includes(:companies)
        @reviews = Review.all.limit(6)
        @companies = Company.where(approved: true).joins(:reviews).select("companies.id, companies.name, companies.description, avg(reviews.rating) as average_rating, count(reviews.id) as number_of_reviews").group("companies.id, companies.name, companies.description").order("average_rating DESC, number_of_reviews DESC").with_attached_image.limit(8)
    end

    def show
        @category = Category.find(params[:id])
        @companies = Company.where(approved: true, category_id: @category.id).includes(:reviews)
    end

    def new
        @category = Category.new
    end

    def create
        @business = current_business
        @category = @business.categories.new(category_params)
        if @category.save
            redirect_to category_path(@category.id), notice: "Category successfully created"
        else
            render :new, alert: 'Error please try again later!'
        end
    end

    def destroy
        @category = Category.find(params[:id])
        @category.destroy
        redirect_to category_path(@category), status: :see_other
    end

    def edit
    end

    def update
        @category = Category.find(params[:id])
        if @category.update(category_params)
            redirect_to category_path(@category)
        else
            render :edit, alert: 'Error please try again later!'
        end
    end

    def search
        if params[:search].blank?
            redirect_to categories_path and return
        else
            @parameter = params[:search].downcase
            @results = Company.all.where("lower(name) LIKE :search", search: "%#{@parameter}%")
        end
    end

    private

    def category_params
        params.require(:category).permit(:name, :description, :picture)
    end
end
