require 'spec_helper'

describe Applicant do
  it "has a factory" do
    admin = FactoryGirl.create(:applicant)
  end

  context "is created" do
    before(:each) { @applicant = FactoryGirl.build(:applicant) }

    it "is invalid without a firstname" do
      @applicant.firstname = ""
      @applicant.should_not be_valid
    end

    it "is invalid without a lastname" do
      @applicant.lastname = ""
      @applicant.should_not be_valid
    end

    it "is invalid without an email" do
      @applicant.email = ""
      @applicant.should_not be_valid
    end

    it "is invalid without a password" do
      @applicant.password = ""
      @applicant.should_not be_valid
    end

    it "is invalid if the password confirmation does not match the password" do
      @applicant.password = "password"
      @applicant.password_confirmation = "another_password"
      @applicant.should_not be_valid
    end

    it "is invalid if the password is shorter than eight characters" do
      @applicant.password = "asdasda"
      @applicant.password_confirmation = "asdasda"
      @applicant.should_not be_valid
    end

    it "is valid if the password is 8 characters" do
      @applicant.password = "12345678"
      @applicant.password_confirmation = "12345678"
      @applicant.should be_valid
    end
  end
end
