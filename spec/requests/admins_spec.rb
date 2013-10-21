require 'spec_helper'

describe "Admins" do
  describe "" do
    it "can login, and create an advertisement." do
	  	admin = FactoryGirl.create(:admin)
	  	advertisement = FactoryGirl.create(:advertisement)
	  	advertisement_count = Advertisement.all.count
	    visit "/users/sign_in"

	    fill_in "Email",    :with => admin.email
	    fill_in "Password", :with => "testpass"

	    click_button "Sign in"

	    page.should have_content("Signed in successfully.")
	    
	    assert_equal admin_root_url, current_url

	    click_link "Advertisements"

	    page.should have_content("Current advertisements")

	    click_link "New Advertisement"

	    fill_in "Title", with: "Title"
	    fill_in "Location", with: "Here"
	    fill_in "Requirement", with: "Tests"
	    fill_in "Description", with: "Lore ipsum text here"

	    click_button "Create Advertisement"

	    page.should have_content("Advertisement was successfully created.")

	    ad = Advertisement.last

	    assert_equal current_url, advertisement_url(ad)
	    assert_equal Advertisement.all.count, advertisement_count + 1
	    page.should have_content(ad.title)
	    page.should have_content(ad.description)
	    page.should have_content(ad.location)
	    page.should have_content(ad.requirement)

	    click_link "Admin area"
	    click_link "Advertisements"

	    page.should have_content(ad.title)
	    page.should have_content(ad.description)
	    page.should have_content(ad.location)
	    page.should have_content(ad.requirement)
    end

    it "can login, and delete an advertisement." do
	  	admin = FactoryGirl.create(:admin)
	  	advertisement = FactoryGirl.create(:advertisement)
	  	advertisement_count = Advertisement.all.count
	    visit "/users/sign_in"

	    fill_in "Email",    :with => admin.email
	    fill_in "Password", :with => "testpass"

	    click_button "Sign in"

	    page.should have_content("Signed in successfully.")
	    
	    assert_equal admin_root_url, current_url

	    click_link "Advertisements"

	    page.should have_content("Current advertisements")
	    page.should have_content(advertisement.title)
	    page.should have_content(advertisement.description)
	    page.should have_content(advertisement.location)
	    page.should have_content(advertisement.requirement)

	    click_link "Destroy"

	    page.should have_content("Advertisement was successfully deleted.")

	    page.should_not have_content(advertisement.title)
	    page.should_not have_content(advertisement.description)
	    page.should_not have_content(advertisement.location)
	    page.should_not have_content(advertisement.requirement)

	    assert_equal Advertisement.all.count, advertisement_count - 1
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
	    
	    click_link "Delete"

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

	    page.should have_content("Delete")

	    page.should have_content(applicant.firstname)
	    page.should have_content(applicant.lastname)
	    page.should have_content(applicant.email)
	    
	    click_link "Delete"

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
	    page.should_not have_content("Email")


	    click_button "Update"

		page.should have_content("User was successfully updated.")
	    assert_equal current_path, admin_user_path(applicant)
	    applicant.reload
	    page.should have_content(applicant.firstname)
	    page.should have_content(applicant.lastname)
	    assert_equal "Whatever", applicant.firstname
	    assert_equal "Nope", applicant.lastname
    end

    it "can't see 'Apply now' for advertisements" do
    	admin = FactoryGirl.create(:admin)
    	advertisement = FactoryGirl.create(:advertisement)
	    visit "/users/sign_in"

	    fill_in "Email",    :with => admin.email
	    fill_in "Password", :with => "testpass"

	    click_button "Sign in"

	    page.should have_content("Signed in successfully.")
	    
	    assert_equal admin_root_url, current_url

	    visit root_url

	    page.should have_content(advertisement.title)
	    page.should have_content(advertisement.location)
	    page.should have_content(advertisement.description)
	    page.should have_content(advertisement.requirement)

	    click_link advertisement.title

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
  end
end
