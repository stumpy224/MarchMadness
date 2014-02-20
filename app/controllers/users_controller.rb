class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update]
  http_basic_authenticate_with :name => "stumpy224", :password => "sochi2014", :only => [:create, :edit, :destroy]
  
  def index
    @users = User.all.order(:first_name, :last_name)
  end

  def new
    @user = User.new
  end

  def show
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Participant created successfully."
      redirect_to new_user_path
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, squares_attributes: [:id, :winner_digit, :loser_digit, :year, :_destroy])
  end
end
