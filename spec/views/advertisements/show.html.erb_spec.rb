require 'spec_helper'

describe "advertisements/show" do
  before(:each) do
    @advertisement = assign(:advertisement, stub_model(Advertisement,
      :title => "Title",
      :location => "Location",
      :description => "Description",
      :standort => "Standort",
      :requirement => "Requirement"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Location/)
    rendered.should match(/Description/)
    rendered.should match(/Standort/)
    rendered.should match(/Requirement/)
  end
end
