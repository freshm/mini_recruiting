class Applicant < User
  #has_many :advertisements, through: :job_application
  
  attr_accessible :job_applications_attributes
  
  accepts_nested_attributes_for :job_applications
  
  
  def admin?
    false
  end
  
  def self.model_name
    User.model_name
  end
end
