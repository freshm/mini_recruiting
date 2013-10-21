require 'spec_helper'

describe Advertisement do
  it "has a Factory" do
    advertisement = FactoryGirl.build(:advertisement)
  end

  context "after it was created" do
    before(:each) { @advertisement = FactoryGirl.build(:advertisement)}

    it "is valid " do
      @advertisement.should be_valid
    end

    it "is destroyed after the admin is destroyed" do
      
      admin = @advertisement.admin
      6.times { admin.advertisements.create(description: "w", location: "w", requirement: "w", title: "w") }
      admin.destroy
      Advertisement.any?.should be_false
    end

    it "is invalid without an admin" do
      advertisement = FactoryGirl.build(:advertisement)
      advertisement.admin_id = nil
      advertisement.should_not be_valid
    end

    it "is invalid without a title" do
      @advertisement.title = ""
      @advertisement.should_not be_valid
    end

    it "is invalid without a location" do
      @advertisement.location = ""
      @advertisement.should_not be_valid
    end

    it "is invalid without any requirements" do
      @advertisement.requirement = ""
      @advertisement.should_not be_valid
    end

    it "is invalid without a description" do
      @advertisement.description = ""
      @advertisement.should_not be_valid
    end
  end
end
