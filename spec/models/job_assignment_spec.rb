require 'spec_helper'

describe JobAssignment do
  it "has a factory" do
    assignment = FactoryGirl.create(:job_assignment)
  end
end
