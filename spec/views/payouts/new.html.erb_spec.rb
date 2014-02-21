require 'spec_helper'

describe "payouts/new" do
  before(:each) do
    assign(:payout, stub_model(Payout,
      :game_payout => 1,
      :round => 1,
      :year => "MyString"
    ).as_new_record)
  end

  it "renders new payout form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", payouts_path, "post" do
      assert_select "input#payout_game_payout[name=?]", "payout[game_payout]"
      assert_select "input#payout_round[name=?]", "payout[round]"
      assert_select "input#payout_year[name=?]", "payout[year]"
    end
  end
end
