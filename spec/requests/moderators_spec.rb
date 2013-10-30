require 'spec_helper'

describe "Moderators" do
	before(:each) do
		@moderator = FactoryGirl.create(:moderator)
		moderator = FactoryGirl.create(:moderator)
		job_application = FactoryGirl.create(:job_application)
		visit "/users/sign_in"

		fill_in "Email",    :with => @moderator.email
		fill_in "Password", :with => "testpass"

		click_button "Sign in"
	end


	it "can not see Users" do
		page.should_not have_content("Users")
	end

	it "can not see Vacancies" do
		page.should_not have_content("Vacancies")
	end

	it "can see Job Applications" do
		page.should have_content("Job Applications")
	end

	it "can rate forwarded Applications as good" do
		Capybara.current_session.driver.header('Accept-Language', 'de')
		job_assignment = FactoryGirl.create(:job_assignment, moderator_id: @moderator.id)
		job_assignment.job_application.forward_to_manager

		visit current_path # reload the page to see new assignment

		page.should have_content(job_assignment.job_application.user.fullname)
		page.should have_content(job_assignment.job_application.vacancy.title)

		click_link job_assignment.job_application.vacancy.title

		click_link "rate_as_good_#{job_assignment.job_application.user.email}_#{job_assignment.job_application.vacancy.title}"


		page.should have_content("There are currently no applications to review.")
		page.should have_content("Reviewed the application from #{job_assignment.job_application.user.fullname} for #{job_assignment.job_application.vacancy.title}")

		job_assignment.job_application.reload

		assert_equal job_assignment.job_application.state, "manager_review_listed"
	end

	it "can rate forwarded Applications as bad" do
		Capybara.current_session.driver.header('Accept-Language', 'de')
		job_assignment = FactoryGirl.create(:job_assignment, moderator_id: @moderator.id)
		job_assignment.job_application.forward_to_manager

		visit current_path # reload the page to see new assignment

		page.should have_content(job_assignment.job_application.user.fullname)
		page.should have_content(job_assignment.job_application.vacancy.title)

		click_link job_assignment.job_application.vacancy.title

		click_link "rate_as_bad_#{job_assignment.job_application.user.email}_#{job_assignment.job_application.vacancy.title}"


		page.should have_content("There are currently no applications to review.")
		page.should have_content("Reviewed the application from #{job_assignment.job_application.user.fullname} for #{job_assignment.job_application.vacancy.title}")

		job_assignment.job_application.reload
		assert_equal job_assignment.job_application.state, "manager_review_listed"
	end
end