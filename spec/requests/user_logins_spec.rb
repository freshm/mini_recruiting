require 'spec_helper'

describe "UserLogins" do
  describe "after login" do
    it "is redirected to admin root path" do
      admin = FactoryGirl.create(:admin)
      visit new_user_session_path
      fill_in "Email", :with => admin.email
      fill_in "Password", with: "testpass"
      click_button('Sign in')
    end
  end
end
