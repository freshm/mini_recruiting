require 'spec_helper'

describe JobApplication do
  it "has a valid Factory" do
    FactoryGirl.create(:job_application)
  end
  it "raises an error if an admin creates it" do
    admin = FactoryGirl.create(:admin)
    expect {admin.job_applications.create(FactoryGirl.create(:job_application))}.to raise_error NoMethodError
  end
  
  context "creation" do
    before(:each) { @jAp = FactoryGirl.create(:job_application)}
    
    it "should be invalid without an applicant" do
      @jAp.user = nil
      @jAp.should_not be_valid
    end
    
    it "should be invalid without an vacancy" do
      @jAp.vacancy = nil
      @jAp.should_not be_valid
    end
    
    it "should be valid without a salary" do
      @jAp.salary = nil
      @jAp.should be_valid
    end
    
    it "should be valid without a note" do
      @jAp.note = nil
      @jAp.should be_valid
    end
    
    it "should be destroy after the applicant is destroyed" do
      user = @jAp.user
      user.destroy
      JobApplication.find_by_id(@jAp.id).should be_nil
    end
    
    it "should be destroy after the applicant is destroyed" do
      vacancy = @jAp.vacancy
      vacancy.destroy
      Vacancy.find_by_id(@jAp.id).should be_nil
    end
  end
end
