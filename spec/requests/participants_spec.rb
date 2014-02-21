require 'spec_helper'

describe "Participants" do
  subject { page }

  describe "show a participant" do
    let(:participant) { FactoryGirl.create(:participant) }
    before { visit participant_path(participant) }

    # it { should have_title(user.first_name + ' ' + user.last_name) }
    it { should have_content(participant.name) }
  end

  describe "create a participant" do
    let(:submit) { "Create Participant" }
    before { visit new_participant_path }

    describe "with invalid information" do
      it "should not create a participant" do
        expect { click_button submit }.not_to change(Participant, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",   with: "John Doe"
      end

      it "should create a participant" do
        expect { click_button submit }.to change(Participant, :count).by(1)
      end
    end
  end
end