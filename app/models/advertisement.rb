class Advertisement < ActiveRecord::Base
  belongs_to :admin,dependent: :destroy
  attr_accessible :description, :location, :requirement, :title

  validates_presence_of :description, :location, :requirement, :title, :admin_id
end