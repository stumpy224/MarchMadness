require 'spec_helper'

describe Region do
  describe "validation" do
    before { @region = Region.new(name: "Midwest", year: "2014", style: "padding-right:0px;", quadrant_id: 1) }

    subject { @region } 

    it { should be_an_instance_of Region }
    it { should respond_to :name }
    it { should respond_to :year }
    it { should respond_to :quadrant_id }

    it { should be_valid }

    describe "when name is not present" do
      before { @region.name = " "}
      it { should_not be_valid }
    end

    describe "when year is not present" do
      before { @region.year = " " }
      it { should_not be_valid }
    end

    describe "when quadrant_id is not present" do
      before { @region.quadrant_id = " " }
      it { should_not be_valid }
    end
  end
end
