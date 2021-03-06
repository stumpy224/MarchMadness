require 'spec_helper'

describe "results/edit" do
  before(:each) do
    @result = assign(:result, stub_model(Result,
      :participant_id => 1,
      :round => 1,
      :year => "MyString"
    ))
  end

  it "renders the edit result form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", result_path(@result), "post" do
      assert_select "input#result_participant_id[name=?]", "result[participant_id]"
      assert_select "input#result_round[name=?]", "result[round]"
      assert_select "input#result_year[name=?]", "result[year]"
    end
  end
end
