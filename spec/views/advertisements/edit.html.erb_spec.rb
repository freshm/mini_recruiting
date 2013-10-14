require 'spec_helper'

describe "advertisements/edit" do
  before(:each) do
    @advertisement = assign(:advertisement, stub_model(Advertisement,
      :title => "MyString",
      :location => "MyString",
      :description => "MyString",
      :standort => "MyString",
      :requirement => "MyString"
    ))
  end

  it "renders the edit advertisement form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", advertisement_path(@advertisement), "post" do
      assert_select "input#advertisement_title[name=?]", "advertisement[title]"
      assert_select "input#advertisement_location[name=?]", "advertisement[location]"
      assert_select "input#advertisement_description[name=?]", "advertisement[description]"
      assert_select "input#advertisement_standort[name=?]", "advertisement[standort]"
      assert_select "input#advertisement_requirement[name=?]", "advertisement[requirement]"
    end
  end
end
