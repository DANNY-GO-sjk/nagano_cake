class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admins_home_path
    when User
      home_path
    end
  end

  def after_sign_out_path_for(resource)
      home_path
    
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :family_name,
      :first_name,
      :family_name_yomi,
      :first_name_yomi,
      :postcode,
      :address,
      :phone_number,
      :email,
    ])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end
end
