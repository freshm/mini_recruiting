class JobApplication < ActiveRecord::Base
  attr_accessible :vacancy_id, :applicant_id, :note, :salary
  
  validates_presence_of :vacancy_id, :applicant_id
  validates :applicant_id, :uniqueness => {:scope => :vacancy_id}
  
  #accepts_nested_attributes_for :applicant
  
  belongs_to :applicant
  belongs_to :vacancy
end
