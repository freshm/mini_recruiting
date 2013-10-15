require 'spec_helper'

describe "job_applications/show" do
  before(:each) do
    @job_application = assign(:job_application, stub_model(JobApplication,
      :wage => 1.5,
      :note => "MyText",
      :applicant_id => 1,
      :advertisement_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
