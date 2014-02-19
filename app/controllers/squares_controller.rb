class SquaresController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update]
  http_basic_authenticate_with :name => "stumpy224", :password => "sochi2014", :only => [:create, :edit, :destroy]

  def index
    @users = User.all
    @squares = Square.all
  end

  def new
    @users = User.all
    @square = Square.new
  end

  def show
    # @user = User.find(params(:id))
    @users = User.all
  end

  def create
    @square = Square.new(square_params)
    @users = User.all
    @square.year = Time.new.year
    if @square.save
      flash[:success] = "Squares for participant have been entered."
      redirect_to new_square_path
    else
      render 'new'
    end
  end

  private

  def square_params
    params.require(:square).permit(:user_id, :winner_digit, :loser_digit, :year)
  end
end
