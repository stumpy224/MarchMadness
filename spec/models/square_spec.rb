require 'spec_helper'

describe Square do
  before { @square = Square.new(winner_digit: 0, loser_digit: 0) }

  subject { @square }

  it { should be_an_instance_of Square }
  it { should respond_to :id }
  it { should respond_to :winner_digit }
  it { should respond_to :loser_digit }

  it { should be_valid }

  describe "when winner_digit is not present" do
    before { @square.winner_digit = " " }
    it { should_not be_valid }
  end

  describe "when loser_digit is not present" do
    before { @square.loser_digit = " " }
    it { should_not be_valid }
  end
end
