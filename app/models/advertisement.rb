class Advertisement < ActiveRecord::Base
  belongs_to :admin
  has_many :job_applications, dependent: :destroy
  #has_many :applicants, through: :job_application
  attr_accessible :description, :location, :requirement, :title


  validates_presence_of :description, :location, :requirement, :title, :admin_id
  
  def already_taken_by_user?(user)
    if JobApplication.where(advertisement_id: self.id, applicant_id: user.id).any?
      true
    else
      false
    end
  end
  
  def display_user_details(user)
    application = user.job_applications.find_by_advertisement_id(self.id)
    wage = application.wage || "You haven't entered a wage"
    application.note = "You haven't entered a note" if application.note.empty?
    [wage, application.note, application.id]
  end
end
