require 'spec_helper'

describe "UserLogins" do
  describe "GET /user_logins" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get user_logins_path
      response.status.should be(200)
    end
  end
end
