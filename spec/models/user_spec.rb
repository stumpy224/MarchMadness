require 'spec_helper'

describe User do
	before { @user = User.new(first_name: "Jeremiah", last_name: "Stump") }

	subject { @user }

	it { should be_an_instance_of User }
	it { should respond_to(:first_name) }
	it { should respond_to(:last_name) }

	it { should be_valid }

	describe "when first_name is not present" do
		before { @user.first_name = " " }
		it { should_not be_valid }
	end

	describe "when last_name is not present" do
		before { @user.last_name = " " }
		it { should_not be_valid}
	end
end
