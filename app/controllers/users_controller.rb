class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
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
			params.require(:user).permit(:first_name, :last_name)
		end
end
