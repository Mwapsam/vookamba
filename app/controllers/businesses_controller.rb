class BusinessesController < ApplicationController
  before_action :authenticate_user!
  def index
    @businesses = Business.all
  end

  def destroy
    @business = Business.find(params[:id])
    @business.destroy
    redirect_to businesses_path
  end
end
