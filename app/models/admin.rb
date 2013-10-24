class Admin < User
  has_many :vacancies, dependent: :destroy
  def admin?
    true
  end

  def self.model_name
    User.model_name
  end
end
