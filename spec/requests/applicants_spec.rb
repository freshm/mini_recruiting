require 'spec_helper'

describe "Applicants" do
  it "can login, click on an vacancy and apply for it." do
  	applicant = FactoryGirl.create(:applicant)
  	vacancy = FactoryGirl.create(:vacancy)
    visit "/users/sign_in"

    fill_in "Email",    :with => applicant.email
    fill_in "Password", :with => "testpass"

    click_button "Sign in"

    page.should have_content("Signed in successfully.")
    
    assert_equal root_url, current_url

    click_link vacancy.title

    click_link "Apply now!"

    fill_in "Salary", with: 12.0
    fill_in "Note", with: "Lore ipsum text"

    click_button "Create Job application"

    page.should have_content "Job application was successfully created."

    assert_equal current_path, vacancy_path(vacancy)
    assert_equal applicant.job_applications.last.salary, JobApplication.last.salary
    assert_equal applicant.job_applications.last.note, JobApplication.last.note
    assert_equal Vacancy.last.job_applications.last, JobApplication.last
    assert_equal applicant.job_applications.last, JobApplication.last
  end

  it "can login, and edit the profile." do
  	applicant = FactoryGirl.create(:applicant)
    visit "/users/sign_in"

    fill_in "Email",    :with => applicant.email
    fill_in "Password", :with => "testpass"

    click_button "Sign in"

    page.should have_content("Signed in successfully.")
    
    assert_equal root_url, current_url

    click_link "Edit"


    page.should have_content("Firstname")
    page.should have_content("Lastname")
    page.should have_content("Email")
    page.should have_content("Password")
    page.should have_content("New Password Confirmation")
    page.should have_content("Current Password")

    fill_in "Firstname", with: "Whatever"
    fill_in "Lastname", with: "Maeh"
    fill_in "Email", with: "maeh@maeh.com"
    fill_in "Current Password", with: "testpass"
    click_button "Update"

    assert_equal current_url, root_url
  end

  it "can log out" do
        applicant = FactoryGirl.create(:applicant)
        visit "/users/sign_in"

        fill_in "Email",    :with => applicant.email
        fill_in "Password", :with => "testpass"

        click_button "Sign in"

        page.should have_content("Signed in successfully.")
        
        click_link ("Log out")

        page.should have_content("Signed out successfully.")
    end
end
