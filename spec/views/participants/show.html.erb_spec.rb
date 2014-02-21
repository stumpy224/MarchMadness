require 'spec_helper'

describe "participants/show" do
  before(:each) do
    @participant = assign(:participant, stub_model(Participant,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
