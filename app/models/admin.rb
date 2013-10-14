class Admin < User
  def admin?
    true
  end
  
  def self.model_name
    User.model_name
  end
end
