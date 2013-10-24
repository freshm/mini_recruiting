class JobApplication < ActiveRecord::Base
  attr_accessible :vacancy_id, :applicant_id, :note, :salary
  
  validates_presence_of :vacancy_id, :applicant_id
  validates :applicant_id, :uniqueness => {:scope => :vacancy_id}
  
  #accepts_nested_attributes_for :applicant
  
  belongs_to :applicant
  belongs_to :vacancy

  state_machine :initial => :send do

  	event :reject do
  		transition :send => :rejected
  		transition :manager_review_listed => :rejected
  	end

  	event :forward_to_manager do
  		transition :send => :manager_review
  	end

  	event :mark_as_good do
  		transition :manager_review => :manager_review_listed
  	end

  	event :mark_as_bad do
  		transition :manager_review => :manager_review_listed
  	end

  	event :employ do
  		transition :manager_review_listed => :employed
  	end
  end

  def self.find_by_state(state)
  	self.where(state: state)
  end
end
