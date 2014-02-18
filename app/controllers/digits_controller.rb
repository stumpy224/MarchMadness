class DigitsController < ApplicationController
	before_filter :authenticate, :only => [:edit, :update]
	http_basic_authenticate_with :name => "stumpy", :password => "sochi2014", :only => [:create, :edit, :destroy]

	def index
		@users = User.all
		@digits = Digit.all
	end

  def new
  	@users = User.all
  	@digit = Digit.new
  end

  def show
  	# @user = User.find(params(:id))
  	@users = User.all
  	# @digits = Digit.find(params(:id))
  end

  def create
  	@digit = Digit.new(digit_params)
  	@users = User.all
  	@digit.year = Time.new.year
		if @digit.save
			flash[:success] = "Digits for participant have been entered."
			redirect_to new_digit_path
		else
			render 'new'
		end
  end

  private

		def digit_params
			params.require(:digit).permit(:user_id, :winner_digit, :loser_digit, :year)
		end
end
