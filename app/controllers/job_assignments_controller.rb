class JobAssignmentsController < ApplicationController
	def create
		application_id = params[:job_assignment]["job_application"]
		manager_id = params[:job_assignment]["manager_id"]
		j = JobApplication.find_by_id(application_id)
		j.forward_to_manager
		@assignment = JobAssignment.new(manager_id: manager_id, job_application_id: application_id)

		if @assignment.save
			ApplicationNotifier.forwarded_application(@assignment).deliver
			respond_to do |format|
		      format.html { redirect_to admin_job_application_path(@assignment.job_application.vacancy.id), notice: "Assigned #{@assignment.manager.fullname}" }
		      format.js
		    end
		else
			flash[:error] = "Moderator was already assigned to this job application."
			redirect_to select_moderator_path(application_id)
		end
	end
end

# @job_application = JobApplication.new(params[:job_application])
#     @vacancy = Vacancy.find_by_id(params[:vacancy_id]);
#     if user_signed_in? && !current_user.admin?
#       applicant = Applicant.find_by_id(current_user.id)
#       @job_application.applicant_id = current_user.id
#       @job_application.vacancy_id = @vacancy.id
#     end
    
#     respond_to do |format|
#       if @job_application.save
#         format.html { redirect_to @vacancy, notice: 'Job application was successfully created.' }
#         format.json { render json: @job_application, status: :created, location: [applicant, @job_application] }
#       else
#         format.html { render action: "new" }
#         format.json { render json: @job_application.errors, status: :unprocessable_entity }
#       end
#     end