class JobAssignment < ActiveRecord::Base
  attr_accessible :job_application_id, :moderator_id

  validates_presence_of :moderator_id, :job_application_id

  belongs_to :job_application
  belongs_to :moderator
end
