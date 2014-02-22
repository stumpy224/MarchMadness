require 'spec_helper'

describe "results/new" do
  before(:each) do
    assign(:result, stub_model(Result,
      :participant_id => 1,
      :round => 1,
      :year => "MyString"
    ).as_new_record)
  end

  it "renders new result form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", results_path, "post" do
      assert_select "input#result_participant_id[name=?]", "result[participant_id]"
      assert_select "input#result_round[name=?]", "result[round]"
      assert_select "input#result_year[name=?]", "result[year]"
    end
  end
end
