require 'spec_helper'

describe Vacancy do
  it "has a Factory" do
    vacancy = FactoryGirl.build(:vacancy)
  end

  context "after it was created" do
    before(:each) { @vacancy = FactoryGirl.build(:vacancy)}

    it "is valid " do
      @vacancy.should be_valid
    end

    it "is destroyed after the admin is destroyed" do
      
      admin = @vacancy.admin
      6.times { admin.vacancies.create(description: "w", location: "w", requirement: "w", title: "w") }
      admin.destroy
      Vacancy.any?.should be_false
    end

    it "is invalid without an admin" do
      vacancy = FactoryGirl.build(:vacancy)
      vacancy.admin_id = nil
      vacancy.should_not be_valid
    end

    it "is invalid without any duty" do
      vacancy = FactoryGirl.build(:vacancy)
      vacancy.duties = nil
      vacancy.should_not be_valid
    end

    it "is invalid without a title" do
      @vacancy.title = ""
      @vacancy.should_not be_valid
    end

    it "is invalid without a location" do
      @vacancy.location = ""
      @vacancy.should_not be_valid
    end

    it "is invalid without any requirements" do
      @vacancy.requirement = ""
      @vacancy.should_not be_valid
    end

    it "is invalid without a description" do
      @vacancy.description = ""
      @vacancy.should_not be_valid
    end
  end
end
