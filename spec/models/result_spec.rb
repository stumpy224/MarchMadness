require 'spec_helper'

describe Result do

  before { @result = Result.new(participant_id: 1, round: 2, year: "2014") }

  subject { @result }

  it { should be_an_instance_of Result }
  it { should respond_to :id }
  it { should respond_to :participant_id }
  it { should respond_to :round }
  it { should respond_to :year }

  it { should be_valid }

  describe "when participant_id is not present" do
    before { @result.participant_id = " " }
    it { should_not be_valid }
  end

  describe "when round is not present" do
    before { @result.round = " " }
    it { should_not be_valid }
  end

  describe "when year is not present" do
    before { @result.year = " " }
    it { should_not be_valid }
  end
end
