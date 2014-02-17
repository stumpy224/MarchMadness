class DigitsController < ApplicationController
  def new
  	@digit = Digit.new
	@users = User.all
  end

  def show
  	@digit = Digit.find(params(:id))
  end

  def create
  	@digit = Digit.new(digit_params)
  	@users = User.all
		if @digit.save
			flash[:success] = "User's digits have been entered."
			redirect_to new_digits_path
		else
			render 'new'
		end
  end

  private

		def digit_params
			params.require(:digit).permit(:user_id, :winner_digit, :loser_digit, :year)
		end
end
