class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
    @businesses = Business.all
  end

  def show
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end
end
