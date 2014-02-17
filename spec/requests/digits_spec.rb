require 'spec_helper'

describe "Digits" do
  describe "show participant's digits" do
  	it "should have title of 'Participant Digits" do
  		# @digit = FactoryGirl.create(:digit)

  		visit digit_path(FactoryGirl.create(:digit))
  		expect(page).to have_title("Participant Digits")
  	end

  	# it "should have title of participant's name" do
	  # 		@user = FactoryGirl.create(:user)
	  # 		@digit = FactoryGirl.create(:digit)

  	# 	visit digit_path(digit)
  	# 	expect(page).to have_title(@user.first_name + ' ' + @user.last_name)
  	# end
  end
end
