require 'spec_helper'

describe "Pages" do
  describe "Results page" do
    before do
      visit root_path
    end

    it "should have the title 'Results'" do
      expect(page).to have_title("Results")
    end

    it "should have the content 'Results'" do
      expect(page).to have_content("Results")
    end
  end

  describe "Bracket page" do
    
  end
end
