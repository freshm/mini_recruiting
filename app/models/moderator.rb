class Moderator < User
	has_many :job_assignments, dependent: :destroy
	has_many :job_applications, through: :job_assignments
	def admin?
		false
	end

	def self.model_name
		User.model_name
	end

	protected

	def set_default_title
		self.fullname
	end
end