class Advertisement < ActiveRecord::Base
  belongs_to :admin,dependent: :destroy
  has_many :job_applications
  has_many :applicants, through: :job_application
  attr_accessible :description, :location, :requirement, :title

  validates_presence_of :description, :location, :requirement, :title, :admin_id
end
