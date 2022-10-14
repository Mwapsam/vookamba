class CompaniesController < ApplicationController
    before_action :authenticate_business!, except: %i[index show top admin_companies]
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
        @user = current_business
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
        @top_rated = Category.all
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
