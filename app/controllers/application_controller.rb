class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :admin?

  private

    def admin?
      (session[:user_name] == ADMIN_USERNAME) && (session[:password] == ADMIN_PASSWORD) 
    end

    def authorize
      unless admin?
        flash[:error] = "You are not an authorized Administrator"
        redirect_to home_path
        false
      end
    end
end
