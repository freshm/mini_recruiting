class JobApplication < ActiveRecord::Base
  attr_accessible :advertisement_id, :applicant_id, :note, :wage
end
