module VacanciesHelper
	def can_apply?(user)
		if user == nil
			true
		elsif user.admin? || user.type == "Manager"
			false
		else
			true
		end
	end
end
