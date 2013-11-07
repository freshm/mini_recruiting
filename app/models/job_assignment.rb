class JobAssignment < ActiveRecord::Base
  attr_accessible :job_application_id, :manager_id

  validates_presence_of :manager_id, :job_application_id

  belongs_to :job_application
  belongs_to :manager
end
