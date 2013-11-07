require 'spec_helper'

describe "Admins" do
  describe "" do
    it "can login, and create an vacancy." do
	  	admin = FactoryGirl.create(:admin)
	  	vacancy = FactoryGirl.create(:vacancy)
	  	vacancy_count = Vacancy.all.count
	    visit "/users/sign_in"

	    fill_in "Email",    :with => admin.email
	    fill_in "Password", :with => "testpass"

	    click_button "Sign in"

	    page.should have_content("Signed in successfully.")
	    
	    assert_equal admin_root_url, current_url

	    click_link "Vacancies"

	    page.should have_content("Current vacancies")

	    click_link "new_link_top"

	    fill_in "vacancy_title", with: "Title"
	    fill_in "vacancy_location", with: "Here"
	    fill_in "vacancy_requirement", with: "Tests"
	    fill_in "vacancy_description", with: "Lore ipsum text here"
	    fill_in "vacancy_duties", with: "Do something"

	    click_button "Create Vacancy"

	    page.should have_content("Vacancy was successfully created.")

	    vacancy = Vacancy.last

	    assert_equal current_url, admin_vacancy_url(vacancy)
	    assert_equal Vacancy.all.count, vacancy_count + 1
	    page.should have_content(vacancy.title)
	    page.should have_content(vacancy.description)
	    page.should have_content(vacancy.location)
	    page.should have_content(vacancy.requirement)

	    click_link "Admin area"
	    click_link "Vacancies"

	    page.should have_content(vacancy.title)
	    page.should have_content(vacancy.description)
	    page.should have_content(vacancy.location)
	    page.should have_content(vacancy.requirement)
    end

    it "can login, and delete an vacancy." do
	  	admin = FactoryGirl.create(:admin)
	  	vacancy = FactoryGirl.create(:vacancy)
	  	vacancy_count = Vacancy.all.count
	    visit "/users/sign_in"

	    fill_in "Email",    :with => admin.email
	    fill_in "Password", :with => "testpass"

	    click_button "Sign in"

	    page.should have_content("Signed in successfully.")
	    
	    assert_equal admin_root_url, current_url

	    click_link "Vacancies"

	    page.should have_content("Current vacancies")
	    page.should have_content(vacancy.title)
	    page.should have_content(vacancy.description)
	    page.should have_content(vacancy.location)
	    page.should have_content(vacancy.requirement)

	    click_link "delete_#{vacancy.title}"

	    page.should have_content("Vacancy was successfully deleted.")

	    page.should_not have_content(vacancy.title)
	    page.should_not have_content(vacancy.description)
	    page.should_not have_content(vacancy.location)
	    page.should_not have_content(vacancy.requirement)

	    assert_equal Vacancy.all.count, vacancy_count - 1
    end

    it "can see the delete button for applicants, not for admins " do
    	admin = FactoryGirl.create(:admin)
	  	applicant = FactoryGirl.create(:applicant)
	  	applicant_count = Applicant.all.count
	    visit "/users/sign_in"

	    fill_in "Email",    :with => admin.email
	    fill_in "Password", :with => "testpass"

	    click_button "Sign in"

	    page.should have_content("Signed in successfully.")
	    
	    assert_equal admin_root_url, current_url

	    page.should have_content(applicant.firstname)
	    page.should have_content(applicant.lastname)
	    page.should have_content(applicant.email)

	    click_link "delete_#{applicant.email}"

	    page.should_not have_content(applicant.firstname)
	    page.should_not have_content(applicant.lastname)
	    page.should_not have_content(applicant.email)

	    assert_equal current_url, admin_root_url
	    assert_equal Applicant.all.count, applicant_count - 1 	
    end

    it "can see the delete button for applicants and can delete the applicant" do
    	admin = FactoryGirl.create(:admin)
	  	applicant = FactoryGirl.create(:applicant)
	  	applicant_count = Applicant.all.count
	    visit "/users/sign_in"

	    fill_in "Email",    :with => admin.email
	    fill_in "Password", :with => "testpass"

	    click_button "Sign in"

	    page.should have_content("Signed in successfully.")
	    
	    assert_equal admin_root_url, current_url

	    page.should have_content(applicant.firstname)
	    page.should have_content(applicant.lastname)
	    page.should have_content(applicant.email)
	    
	    click_link "delete_#{applicant.email}"

	    page.should_not have_content(applicant.firstname)
	    page.should_not have_content(applicant.lastname)
	    page.should_not have_content(applicant.email)

	    assert_equal current_url, admin_root_url
	    assert_equal Applicant.all.count, applicant_count - 1 	
    end

    it "can see the details for an applicant and edit them" do
    	admin = FactoryGirl.create(:admin)
	  	applicant = FactoryGirl.create(:applicant)
	    visit "/users/sign_in"

	    fill_in "Email",    :with => admin.email
	    fill_in "Password", :with => "testpass"

	    click_button "Sign in"

	    page.should have_content("Signed in successfully.")
	    
	    assert_equal admin_root_url, current_url

	    page.should have_content(applicant.firstname)
	    page.should have_content(applicant.lastname)
	    page.should have_content(applicant.email)

	    click_link applicant.email

	    page.should have_content(applicant.firstname)
	    page.should have_content(applicant.lastname)
	    page.should have_content(applicant.email)

	    page.should have_content("Back")
	    page.should have_content("Edit")

	    click_link "Edit"

	    fill_in "Firstname", with: "Whatever"
	    fill_in "Lastname", with: "Nope"


	    click_button "Update"

		page.should have_content("User was successfully updated.")
	    assert_equal current_path, admin_user_path(applicant)
	    applicant.reload
	    page.should have_content(applicant.firstname)
	    page.should have_content(applicant.lastname)
	    assert_equal "Whatever", applicant.firstname
	    assert_equal "Nope", applicant.lastname
    end

    it "can't see 'Apply now' for vacancies" do
    	admin = FactoryGirl.create(:admin)
    	vacancy = FactoryGirl.create(:vacancy)
	    visit "/users/sign_in"

	    fill_in "Email",    :with => admin.email
	    fill_in "Password", :with => "testpass"

	    click_button "Sign in"

	    page.should have_content("Signed in successfully.")
	    
	    assert_equal admin_root_url, current_url

	    visit root_url

	    page.should have_content(vacancy.title)
	    page.should have_content(vacancy.location)

	    click_link vacancy.title

   	    page.should_not have_content("Apply now")
    end

    it "can log out" do
    	admin = FactoryGirl.create(:admin)
	    visit "/users/sign_in"

	    fill_in "Email",    :with => admin.email
	    fill_in "Password", :with => "testpass"

	    click_button "Sign in"

	    page.should have_content("Signed in successfully.")
	    
	    click_link ("Log out")

	    page.should have_content("Signed out successfully.")
	end

	it "can forward an new application" do
		Capybara.current_session.driver.header('Accept-Language', 'de')
	  	admin = FactoryGirl.create(:admin)
	  	manager = FactoryGirl.create(:manager)
	  	job_application = FactoryGirl.create(:job_application)
	    visit "/users/sign_in"

	    fill_in "Email",    :with => admin.email
	    fill_in "Password", :with => "testpass"

	    click_button "Sign in"

	    page.should have_content("Signed in successfully.")

	    click_link "Job Applications"

	    click_link job_application.vacancy.title

	    click_link "Forward"

	    click_button "Forward to manager"

	    page.should have_content("Assigned #{manager.fullname}")
	    job_application.reload
	    assert_equal job_application.state, "manager_review"
	end

	it "can reject new and reviewed applications" do
		Capybara.current_session.driver.header('Accept-Language', 'de')
	  	admin = FactoryGirl.create(:admin)
	  	vacancy = FactoryGirl.create(:vacancy)
	  	job_application1 = FactoryGirl.create(:job_application, vacancy_id: vacancy.id)
	  	job_application2 = FactoryGirl.create(:job_application, vacancy_id: vacancy.id)
	  	job_application2.state = "manager_review_listed"
	  	job_application2.save
	    visit "/users/sign_in"

	    fill_in "Email",    :with => admin.email
	    fill_in "Password", :with => "testpass"

	    click_button "Sign in"

	    page.should have_content("Signed in successfully.")

	    click_link "Job Applications"

	    click_link vacancy.title

	    click_link "reject_#{job_application1.id}"

	    page.should have_content("Rejected the application from #{job_application1.user.fullname} for #{job_application1.vacancy.title}")

	    
	    click_link "reject_#{job_application2.id}"
	    page.should have_content("Rejected the application from #{job_application2.user.fullname} for #{job_application2.vacancy.title}")
	end

	it "can employ a reviewed applications" do
		Capybara.current_session.driver.header('Accept-Language', 'de')
	  	admin = FactoryGirl.create(:admin)
	  	vacancy = FactoryGirl.create(:vacancy)
	  	job_application = FactoryGirl.create(:job_application, vacancy_id: vacancy.id)
	  	job_application.state = "manager_review_listed"
	  	job_application.save
	    visit "/users/sign_in"

	    fill_in "Email",    :with => admin.email
	    fill_in "Password", :with => "testpass"

	    click_button "Sign in"

	    page.should have_content("Signed in successfully.")

	    click_link "Job Applications"

	    click_link vacancy.title
	    
	    click_link "employ_#{job_application.id}"
	    page.should have_content("Employed #{job_application.user.fullname} for #{job_application.vacancy.title}")
	end
  end
end
