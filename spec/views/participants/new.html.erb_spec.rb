require 'spec_helper'

describe "participants/new" do
  before(:each) do
    assign(:participant, stub_model(Participant,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new participant form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", participants_path, "post" do
      assert_select "input#participant_name[name=?]", "participant[name]"
    end
  end
end
