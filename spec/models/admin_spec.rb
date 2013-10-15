require 'spec_helper'

describe Admin do
  it "has a factory" do
    FactoryGirl.create(:admin)
  end

  context "is created" do
    before(:each) { @admin = FactoryGirl.create(:admin) }

    it "is invalid without a firstname" do
      @admin.firstname = ""
      @admin.should_not be_valid
    end
    
    it "is invalid if the email is not unique" do
      snd_admin = FactoryGirl.build(:admin)
      snd_admin.email = @admin.email
      snd_admin.save.should == false
    end

    it "is invalid without a lastname" do
      @admin.lastname = ""
      @admin.should_not be_valid
    end

    it "is invalid without an email" do
      @admin.email = ""
      @admin.should_not be_valid
    end

    it "is invalid without a password" do
      @admin.password = ""
      @admin.should_not be_valid
    end

    it "is invalid if the password confirmation does not match the password" do
      @admin.password = "password"
      @admin.password_confirmation = "another_password"
      @admin.should_not be_valid
    end

    it "is invalid if the password is shorter than eight characters" do
      @admin.password = "asdasda"
      @admin.password_confirmation = "asdasda"
      @admin.should_not be_valid
    end

    it "is valid if the password is 8 characters" do
      @admin.password = "12345678"
      @admin.password_confirmation = "12345678"
      @admin.should be_valid
    end
  end
end
