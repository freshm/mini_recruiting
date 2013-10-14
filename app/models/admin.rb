class Admin < User
  has_many :advertisements
  def admin?
    true
  end 
  
  def self.model_name
    User.model_name
  end
end
