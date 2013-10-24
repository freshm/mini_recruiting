class Moderator < User
	def admin?
		false
	end

	def self.model_name
	    User.model_name
	  end
end