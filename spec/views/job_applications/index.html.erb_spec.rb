require 'spec_helper'

describe "job_applications/index" do
  before(:each) do
    assign(:job_applications, [
      stub_model(JobApplication,
        :wage => 1.5,
        :note => "MyText",
        :applicant_id => 1,
        :advertisement_id => 2
      ),
      stub_model(JobApplication,
        :wage => 1.5,
        :note => "MyText",
        :applicant_id => 1,
        :advertisement_id => 2
      )
    ])
  end

  it "renders a list of job_applications" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
