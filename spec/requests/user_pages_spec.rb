require 'spec_helper'

describe "User pages" do

	subject { page }

	describe "Show participant" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }

		it { should have_title(user.first_name + ' ' + user.last_name) }
		it { should have_content(user.first_name) }
		it { should have_content(user.last_name) }
	end

	describe "Create participant" do
		let(:submit) { "Create" }
		before { visit new_user_path }

		describe "with invalid information" do
			it "should not create a participant" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "First name",		with: "testFirstName"
				fill_in "Last name",		with: "testLastName"
			end

			it "should create a participant" do
				expect { click_button submit }.to change(User, :count).by(1)
			end
		end
	end
end