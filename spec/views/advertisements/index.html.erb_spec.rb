require 'spec_helper'

describe "advertisements/index" do
  before(:each) do
    assign(:advertisements, [
      stub_model(Advertisement,
        :title => "Title",
        :location => "Location",
        :description => "Description",
        :standort => "Standort",
        :requirement => "Requirement"
      ),
      stub_model(Advertisement,
        :title => "Title",
        :location => "Location",
        :description => "Description",
        :standort => "Standort",
        :requirement => "Requirement"
      )
    ])
  end

  it "renders a list of advertisements" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Standort".to_s, :count => 2
    assert_select "tr>td", :text => "Requirement".to_s, :count => 2
  end
end
