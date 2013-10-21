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
      @jAp.applicant = nil
      @jAp.should_not be_valid
    end
    
    it "should be invalid without an advertisement" do
      @jAp.advertisement = nil
      @jAp.should_not be_valid
    end
    
    it "should be valid without a wage" do
      @jAp.wage = nil
      @jAp.should be_valid
    end
    
    it "should be valid without a note" do
      @jAp.note = nil
      @jAp.should be_valid
    end
    
    it "should be destroy after the applicant is destroyed" do
      app = @jAp.applicant
      app.destroy
      JobApplication.find_by_id(@jAp.id).should be_nil
    end
    
    it "should be destroy after the applicant is destroyed" do
      adv = @jAp.advertisement
      adv.destroy
      Advertisement.find_by_id(@jAp.id).should be_nil
    end
  end
end
