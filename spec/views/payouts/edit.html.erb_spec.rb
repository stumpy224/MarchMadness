require 'spec_helper'

describe "payouts/edit" do
  before(:each) do
    @payout = assign(:payout, stub_model(Payout,
      :game_payout => 1,
      :round => 1,
      :year => "MyString"
    ))
  end

  it "renders the edit payout form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", payout_path(@payout), "post" do
      assert_select "input#payout_game_payout[name=?]", "payout[game_payout]"
      assert_select "input#payout_round[name=?]", "payout[round]"
      assert_select "input#payout_year[name=?]", "payout[year]"
    end
  end
end
