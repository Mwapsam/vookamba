class CategoriesController < ApplicationController
    before_action :authenticate_user!, except: %i[index show]

    def index
        @categories = Category.all.includes(:companies)
    end

    def show
        @category = Category.find(params[:id])
        @companies = Company.where(category_id: @category.id)
    end

    def new
        @category = Category.new
    end

    def create
        @user = current_user
        @category = @user.categories.new(category_params)
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

    private

    def category_params
        params.require(:category).permit(:name, :description, :picture)
    end
end
