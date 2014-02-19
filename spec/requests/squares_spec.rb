require 'spec_helper'

describe "Squares" do
  # describe "show squares for participant" do
  #   it "should have title of 'something'" do
  #     # @square = FactoryGirl.create(:square)

  #     visit square_path(FactoryGirl.create(:square))
  #     expect(page).to have_title("Participant Squares")
  #   end

  #   # it "should have title of participant's name" do
   #  #     @user = FactoryGirl.create(:user)
   #  #     @square = FactoryGirl.create(:square)

  #   #   visit square_path(square)
  #   #   expect(page).to have_title(@user.first_name + ' ' + @user.last_name)
  #   # end
  # end

  describe "create a square" do
    let(:enter) { "Enter" }
    before { visit new_square_path }

    describe "with invalid information" do
      it "should not create square for participant" do
        expect { click_button enter }.not_to change(Square, :count)
      end
    end

    describe "with valid information" do
      let(:square) { FactoryGirl.create(:square) }
      before do
        # page.select(Nokogiri::HTML("1").text, from: "digit_user_id")
        # page.select("1", from: "digit_user_id")
        # select "Jeremiah Stump", from: "digit_user_id"
        # find(:select, "digit_user_id").all('option').find{|o| o.value=="1"}.select_option
        select square.user_id, from: "square_user_id"
        fill_in "Winner digit", with: "0"
        fill_in "Loser digit", with: "0"
      end

      it "should create square for participant" do
        expect { click_button enter }.to change(Square, :count).by(1)
      end
    end
  end
end
