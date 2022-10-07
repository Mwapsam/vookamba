class CompaniesController < ApplicationController
    before_action :authenticate_user!, except: %i[index show top]
    before_action :set_company

    def index
        @companies = Company.where(approved: true).includes(:category)
    end

    def show
        @company = Company.find(params[:id])
        if @company.reviews.blank?
            @average_review = 0
        else
            @average_review = @company.reviews.average(:rating).round(2)
        end
    end

    def new
        @company = Company.new
        @category = Category.all
    end

    def create
        @user = current_user
        @company = @user.companies.new(company_params)
        if @company.save
            redirect_to company_path(@company.id), notice: 'Company was created successfully!'
        else 
            render :new, alert: 'Error please try again later!'
        end
    end

    def edit
        Company.find(params[:id])
    end

    def update
        @company = Company.find(params[:id])
        if @company.update(company_params)
            redirect_to company_path(@company.id)
        else
            render :edit, alert: 'Error please try again later!'
        end
    end

    def destroy
        @company = Company.find(params[:id])
        if @company.destroy
            redirect_to companies_path
        else
            flash[:alert] = 'Error please try again later!'
        end
    end

    def top
        @top_rated = Company.where(approved: true).joins(:reviews).select("companies.id, companies.name, avg(reviews.rating) as average_rating, count(reviews.id) as number_of_reviews").group("companies.id, companies.name").order("average_rating DESC, number_of_reviews DESC").with_attached_image
    end

    def admin_companies
        @companies = Company.all
    end

    private

    def set_company
        # @company = Company.find(params[:id])
    end

    def company_params
        params.require(:company).permit(:name, :description, :location, :image, :category_id, :approved)
    end
end
