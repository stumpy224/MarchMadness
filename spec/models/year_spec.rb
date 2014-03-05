require 'spec_helper'

describe Year do

  before { @year = Year.new(year: "2014", source_url: 'http://www.something.com/') }

  subject { @year }

  it { should be_an_instance_of Year }
  it { should respond_to :year }
  it { should respond_to :source_url }
  it { should respond_to :results_last_updated_at }
  it { should respond_to :bracket_last_updated_at }

  it { should be_valid }

  describe "when year is not present" do
    before { @year.year = " " }
    it { should_not be_valid }
  end

  describe "when source_url is not present" do
    before { @year.source_url = " " }
    it { should_not be_valid }
  end
end
