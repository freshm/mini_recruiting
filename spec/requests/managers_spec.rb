require 'spec_helper'

describe "Managers" do
	before(:each) do
		@manager = FactoryGirl.create(:manager)
		manager = FactoryGirl.create(:manager)
		@job_application = FactoryGirl.create(:job_application)
		visit "/users/sign_in"

		fill_in "Email",    :with => @manager.email
		fill_in "Password", :with => "testpass"

		click_button "Sign in"

		page.should have_content("Admin area")
	end

	it "can't see 'Apply now' for vacancies" do
	    page.should have_content("Signed in successfully.")

	    visit root_url

	    page.should have_content(@job_application.vacancy.title)
	    page.should have_content(@job_application.vacancy.location)

	    click_link @job_application.vacancy.title

   	    page.should_not have_content("Apply now")
    end

    it "can edit its profile" do
    	click_link "Edit Profile"

    	

    	fill_in "Firstname", with: "New name"
    	fill_in "Lastname", with: "New lastname"
    	fill_in "Email", with: "new@email.de"
    	fill_in "Current Password", with: "testpass"
    	click_button "Update"

    	page.should have_content "You updated your account successfully."
    	page.should have_content "new@email.de"
    end

    it "can notedit its profile with invalid email" do
    	click_link "Edit Profile"

    	

    	fill_in "Firstname", with: "New name"
    	fill_in "Lastname", with: "New lastname"
    	fill_in "Email", with: "newemail.de"
    	fill_in "Current Password", with: "testpass"
    	click_button "Update"
    	
    	page.should have_content "Email is invalid"
    	page.should have_content @manager.email
    end

	it "can not see Users" do
		page.should_not have_content("Users")
	end

	it "can see a link to the admin area" do
		visit root_url
		page.should have_content("Admin area")
	end

	it "can not see Vacancies" do
		page.should_not have_content("Vacancies")
	end

	it "can see Job Applications" do
		page.should have_content("Job Applications")
	end

	it "can rate forwarded Applications as good" do
		Capybara.current_session.driver.header('Accept-Language', 'de')
		job_assignment = FactoryGirl.create(:job_assignment, manager_id: @manager.id)
		job_assignment.job_application.forward_to_manager

		visit current_path # reload the page to see new assignment

		page.should have_content(job_assignment.job_application.user.fullname)
		page.should have_content(job_assignment.job_application.vacancy.title)

		click_link job_assignment.job_application.vacancy.title

		click_link "rate_as_good_#{job_assignment.job_application.user.email}_#{job_assignment.job_application.vacancy.title}"

		page.should have_content("Reviewed the application from #{job_assignment.job_application.user.fullname} for #{job_assignment.job_application.vacancy.title} as good")

		job_assignment.job_application.reload

		assert_equal job_assignment.job_application.state, "manager_review_listed"
	end

	it "can rate forwarded Applications as bad" do
		Capybara.current_session.driver.header('Accept-Language', 'de')
		job_assignment = FactoryGirl.create(:job_assignment, manager_id: @manager.id)
		job_assignment.job_application.forward_to_manager

		visit current_path # reload the page to see new assignment

		page.should have_content(job_assignment.job_application.user.fullname)
		page.should have_content(job_assignment.job_application.vacancy.title)

		click_link job_assignment.job_application.vacancy.title

		click_link "rate_as_bad_#{job_assignment.job_application.user.email}_#{job_assignment.job_application.vacancy.title}"
		
		page.should have_content("Reviewed the application from #{job_assignment.job_application.user.fullname} for #{job_assignment.job_application.vacancy.title} as bad")

		job_assignment.job_application.reload
		assert_equal job_assignment.job_application.state, "manager_review_listed"
	end
end