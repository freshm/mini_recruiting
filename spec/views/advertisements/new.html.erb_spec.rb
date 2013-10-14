require 'spec_helper'

describe "advertisements/new" do
  before(:each) do
    assign(:advertisement, stub_model(Advertisement,
      :title => "MyString",
      :location => "MyString",
      :description => "MyString",
      :standort => "MyString",
      :requirement => "MyString"
    ).as_new_record)
  end

  it "renders new advertisement form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", advertisements_path, "post" do
      assert_select "input#advertisement_title[name=?]", "advertisement[title]"
      assert_select "input#advertisement_location[name=?]", "advertisement[location]"
      assert_select "input#advertisement_description[name=?]", "advertisement[description]"
      assert_select "input#advertisement_standort[name=?]", "advertisement[standort]"
      assert_select "input#advertisement_requirement[name=?]", "advertisement[requirement]"
    end
  end
end
