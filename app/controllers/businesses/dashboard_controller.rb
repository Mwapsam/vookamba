class Businesses::DashboardController < ApplicationController
  before_action :authenticate_business!
  def index
  end

  def get_companies
    @business = current_business
    @companies = @business.companies.all
  end

  def get_reviews
    business = current_business
    companies = business.companies.all
    @reviews = Review.all.where(company_id: companies.ids)
  end
end
