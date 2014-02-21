require 'spec_helper'

describe "payouts/show" do
  before(:each) do
    @payout = assign(:payout, stub_model(Payout,
      :game_payout => 1,
      :round => 2,
      :year => "Year"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Year/)
  end
end
