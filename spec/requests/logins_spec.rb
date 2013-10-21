require 'spec_helper'

describe "UserPrivileges" do
  it "allows admin to sign in after they have registered" do
    admin = FactoryGirl.create(:admin)

    visit "/users/sign_in"

    fill_in "Email",    :with => admin.email
    fill_in "Password", :with => "testpass"

    click_button "Sign in"

    page.should have_content("Signed in successfully.")
    
    assert_equal admin_root_url, current_url
  end
  
  it "admin can't login with wrong password" do
    admin = FactoryGirl.create(:admin)

    visit "/users/sign_in"

    fill_in "Email",    :with => admin.email
    fill_in "Password", :with => "testpasswrong"

    click_button "Sign in"

    page.should have_content("Invalid email or password.")
    
    assert_equal new_user_session_url, current_url
  end
  
  it "allows applicant to sign in after they have registered" do
    applicant = FactoryGirl.create(:applicant)

    visit "/users/sign_in"

    fill_in "Email",    :with => applicant.email
    fill_in "Password", :with => "testpass"

    click_button "Sign in"

    page.should have_content("Signed in successfully.")
    
    assert_equal root_url, current_url
  end
  
  
  it "does not allow applicants to to got to the sign up page after signed up" do
    applicant = FactoryGirl.create(:applicant)

    visit "/users/sign_in"

    fill_in "Email",    :with => applicant.email
    fill_in "Password", :with => "testpass"

    click_button "Sign in"

    page.should have_content("Signed in successfully.")
    
    assert_equal root_url, current_url
    
    visit "/users/sign_in"
    
    page.should have_content("You are already signed in.")

    assert_equal root_url, current_url
  end
  
  it "does not allow admins to to got to the sign up page after signed up" do
    admin = FactoryGirl.create(:admin)

    visit "/users/sign_in"

    fill_in "Email",    :with => admin.email
    fill_in "Password", :with => "testpass"

    click_button "Sign in"

    page.should have_content("Signed in successfully.")
    
    assert_equal admin_root_url, current_url
    
    visit "/users/sign_in"
    
    page.should have_content("You are already signed in.")

    assert_equal root_url, current_url
  end
end
