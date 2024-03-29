# frozen_string_literal: true

class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    def after_sign_in_path_for(resource)
      case resource
      when User
        appliances_top_path
      when Admin
        admins_top_path
      end
    end
  
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[user_name gender])
    end
  end