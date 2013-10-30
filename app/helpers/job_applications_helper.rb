module JobApplicationsHelper
	def reviewed_by?(job_application)
		if JobAssignment.find_by_job_application_id(job_application.id)
			JobAssignment.find_by_job_application_id(job_application.id).moderator.fullname
		else
			"Not assigned."
		end 
	end

	def send?(application)
		application.state == "send"
	end

	def forwarded?(application)
		application.state == "manager_review"
	end

	def reviewed?(application)
		application.state == "manager_review_listed"
	end
end

