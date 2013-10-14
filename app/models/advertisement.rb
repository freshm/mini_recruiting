class Advertisement < ActiveRecord::Base
  belongs_to :admin
  attr_accessible :description, :location, :requirement, :standort, :title
  
  validates_presence_of :description, :location, :requirement, :title
end
