require 'spec_helper'

describe "UserLogins" do
  describe "after login" do
    it "is redirected to admin root path" do
      admin = FactoryGirl.create(:admin)
      visit new_user_session_path
      click_link "password"
      fill_in "Email", :with => admin.email
      fill_in "Password", with: "testpass"
        
    end
  end
end
