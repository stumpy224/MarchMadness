require 'spec_helper'

describe ParticipantSquare do
  before { @participant_square = ParticipantSquare.new(participant_id: 1, square_id: 1, year: '2013') }

  subject { @participant_square }

  it { should be_an_instance_of ParticipantSquare }
  it { should respond_to(:id, :participant_id, :square_id, :year) }

  it { should be_valid }

  describe "when participant_id is not present" do
    before { @participant_square.participant_id = ' ' }
    it { should_not be_valid }
  end

  describe "when square_id is not present" do
    before { @participant_square.square_id = ' ' }
    it { should_not be_valid }
  end

  describe "when year is not present" do
    before { @participant_square.year = ' ' }
    it { should_not be_valid }
  end
end
