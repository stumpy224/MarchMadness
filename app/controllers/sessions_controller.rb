class SessionsController < ApplicationController
  def create
    session[:user_name] = params[:user_name]
    session[:password] = params[:password]
    flash[:notice] = "Successfully logged in"
    redirect_to root_path
  end

  def destroy
    reset_session
    flash[:notice] = "Successfully logged out"
    redirect_to login_path
  end
end
