require 'spec_helper'

describe Payout do
  describe "validation" do
    before { @payout = Payout.new(game_payout: 5, round: 2, year: "2014") }

    subject { @payout } 

    it { should be_an_instance_of Payout }
    it { should respond_to :game_payout }
    it { should respond_to :round }
    it { should respond_to :year }

    it { should be_valid }

    describe "when game_payout is not present" do
      before { @payout.game_payout = " "}
      it { should_not be_valid }
    end

    describe "when round is not present" do
      before { @payout.round = " " }
      it { should_not be_valid }
    end

    describe "when year is not present" do
      before { @payout.year = " " }
      it { should_not be_valid }
    end
  end
end
