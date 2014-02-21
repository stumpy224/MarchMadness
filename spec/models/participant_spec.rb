require 'spec_helper'

describe Participant do
  before { @participant = Participant.new(name: "Jeremiah Stump") }

  subject { @participant }

  it { should be_an_instance_of Participant }
  it { should respond_to(:name) }

  it { should be_valid }

  describe "when name is not present" do
    before { @participant.name = " " }
    it { should_not be_valid }
  end
end
