require 'spec_helper'

describe "Pages" do
	describe "Results page" do
		before do
			visit '/pages/results'
		end

		it "should have the title 'Results'" do
			expect(page).to have_title("Results")
		end

		it "should have the content 'Results'" do
			expect(page).to have_content("Results")
      		end
	end
end
