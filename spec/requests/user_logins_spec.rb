require 'spec_helper'

describe "User Logins:" do
  describe "-admin-" do
    it "is redirected to admin root path" do
      admin = FactoryGirl.create(:admin)
      visit new_user_session_path
      fill_in "Email", :with => admin.email
      fill_in "Password", with: "testpass"
      click_button('Sign in')
      assert_equal current_url, admin_root_url
    end
  end
  
  describe "-applicant-" do
    it "is redirected to the root page" do
      applicant = FactoryGirl.create(:applicant)
      visit new_user_session_path
      fill_in "Email", :with => applicant.email
      fill_in "Password", with: "testpass"
      click_button('Sign in')
      assert_equal current_url, root_url
    end
  end
  
  context "Users signes up per Sign up link" do
    it "is redirected to the root page with a message." do
      visit root_url
      click_link "Sign up"
      fill_in "Firstname", with: "Test"
      fill_in "Lastname", with: "Person"
      fill_in "Email", with: "idontknow@mini-recruiting.com"
      fill_in "Password*", with: "testpass", exact: true
      fill_in "Password confirmation", with: "testpass", exact: true
      click_button "Create User"
      
      page.should have_content("Welcome! You have signed up successfully.")
      
      assert_equal current_url, root_url
    end
  end
    
  context "User types two different passwords" do
    it "renders Sign up page and display errors" do
      visit root_url
      click_link "Sign up"
      fill_in "Firstname", with: "Test"
      fill_in "Lastname", with: "Person"
      fill_in "Email", with: "idontknow@mini-recruiting.com"
      fill_in "Password*", with: "testpass", exact: true
      fill_in "Password confirmation", with: "testpasss", exact: true
      click_button "Create User"
      
      page.should have_content("Password doesn't match confirmation")
    end
  end
  
  context "User enters an taken email address" do
    it "renders Sign up page and display errors" do
      app = FactoryGirl.create(:applicant)
      visit root_url
      click_link "Sign up"
      fill_in "Firstname", with: "Test"
      fill_in "Lastname", with: "Person"
      fill_in "Email", with: app.email
      fill_in "Password*", with: "testpass", exact: true
      fill_in "Password confirmation", with: "testpasss", exact: true
      click_button "Create User"
      
      page.should have_content("Email has already been taken")
    end
  end
  context "User leaves fields blank" do
    it "renders the Sign up page and displays errors" do
      visit root_url
      click_link "Sign up"
      click_button "Create User"
      
      page.should have_content("Email can't be blank")
      page.should have_content("Firstname can't be blank")
      page.should have_content("Lastname can't be blank")
      page.should have_content("Password can't be blank")
    end
  end
end
