class Applicant < User
  has_many :job_applications
  has_many :advertisements, through: :job_application
  
  
  def admin?
    false
  end
  
  def self.model_name
    User.model_name
  end
end
