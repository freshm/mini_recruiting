class User < ActiveRecord::Base
  has_many :job_applications, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :firstname, :lastname
  
  validates_presence_of :firstname, :lastname
  
  def fullname
    "#{firstname} #{lastname}"
  end

  def admin?
    false
  end

  def to_s
    self.fullname
  end

private
  def mass_assignment_authorizer(role = :default)
      super + [:type]
  end
end
