class Businesses::RegistrationsController < Devise::RegistrationsController
  before_action :get_package
  before_action :update_allowed_parameters, if: :devise_controller?


  include Accessible
  skip_before_action :check_resource, except: [:new, :create]

  private

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :package_id) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password, :current_password, :package_id) }
  end

  def get_package
    @packages = Package.all
  end
end
