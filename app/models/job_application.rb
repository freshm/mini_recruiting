class JobApplication < ActiveRecord::Base
  attr_accessible :advertisement_id, :applicant_id, :note, :wage
  
  validates_presence_of :advertisement_id, :applicant_id
  validates :applicant_id, :uniqueness => {:scope => :advertisement_id}
  
  #accepts_nested_attributes_for :applicant
  
  belongs_to :applicant
  belongs_to :advertisement
end
