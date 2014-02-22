require 'spec_helper'

describe "results/index" do
  before(:each) do
    assign(:results, [
      stub_model(Result,
        :participant_id => 1,
        :round => 2,
        :year => "Year"
      ),
      stub_model(Result,
        :participant_id => 1,
        :round => 2,
        :year => "Year"
      )
    ])
  end

  it "renders a list of results" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Year".to_s, :count => 2
  end
end
