require 'spec_helper'

describe "job_applications/new" do
  before(:each) do
    assign(:job_application, stub_model(JobApplication,
      :wage => 1.5,
      :note => "MyText",
      :applicant_id => 1,
      :advertisement_id => 1
    ).as_new_record)
  end

  it "renders new job_application form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", job_applications_path, "post" do
      assert_select "input#job_application_wage[name=?]", "job_application[wage]"
      assert_select "textarea#job_application_note[name=?]", "job_application[note]"
      assert_select "input#job_application_applicant_id[name=?]", "job_application[applicant_id]"
      assert_select "input#job_application_advertisement_id[name=?]", "job_application[advertisement_id]"
    end
  end
end
