require 'spec_helper'

describe Digit do
  before { @digit = Digit.new(user_id: 1, winner_digit: 0, loser_digit: 0, year: "2014") }

  subject { @digit }

  it { should be_an_instance_of Digit }
  it { should respond_to :user_id }
  it { should respond_to :winner_digit }
  it { should respond_to :loser_digit }
  it { should respond_to :year }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @digit.user_id = " " }
    it { should_not be_valid }
  end

  describe "when winner_digit is not present" do
    before { @digit.winner_digit = " " }
    it { should_not be_valid }
  end

  describe "when loser_digit is not present" do
    before { @digit.loser_digit = " " }
    it { should_not be_valid }
  end

  describe "when year is not present" do
    before { @digit.year = " " }
    it { should_not be_valid }
  end
end