class Manager < User
	has_many :job_assignments, dependent: :destroy
	has_many :applications_to_review, through: :job_assignments, source: :job_application
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