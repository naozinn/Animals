class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
      case resource
      when Admin
        admin_root_path
      when Users
        user_path(resource)
      end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:email,:name])
    devise_parameter_sanitizer.permit(:update,keys: [:introduction,:name])
  end

end
