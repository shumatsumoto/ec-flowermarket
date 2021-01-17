class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :success, :info, :warning, :danger

  def after_sign_in_path_for(resource)
    products_path
  end

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:admin_flag, :username, :zipcode, :address, :tel])
      devise_parameter_sanitizer.permit(:account_update, keys: [:admin_flag, :username, :zipcode, :address, :tel])
    end
end
