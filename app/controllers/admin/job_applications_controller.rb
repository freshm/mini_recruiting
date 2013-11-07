class Admin::JobApplicationsController < ApplicationController
  before_filter :verify_admin, except: [:index, :show, :rate_as_good, :rate_as_bad]
  before_filter :verify_mod_privilges
  # GET /job_applications
  # GET /job_applications.json
  def index
    if current_user.admin?
      @new = JobApplication.where(state: @state)
      @vacancies = Vacancy.all
    else
      @job_assignments = JobAssignment.where(manager_id: current_user.id, reviewed: false)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  # GET /job_applications/1
  # GET /job_applications/1.json
  def show
    @vacancy = Vacancy.find(params[:id])
    @new = JobApplication.where(state: "send", vacancy_id: @vacancy.id).includes(:user)
    @forwarded = JobApplication.where(state: "manager_review", vacancy_id: @vacancy.id).includes(:user)
    @reviewed = JobApplication.where(state: "manager_review_listed", vacancy_id: @vacancy.id).includes(:user)
    @employed = JobApplication.where(state: "employed", vacancy_id: @vacancy.id).includes(:user)
    @rejected = JobApplication.where(state: "rejected", vacancy_id: @vacancy.id).includes(:user)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job_application }
    end
  end

  # GET /job_applications/new
  # GET /job_applications/new.json
  def new
    @vacancy = Vacancy.find_by_id(params[:vacancy_id])
    @job_application = JobApplication.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job_application }
    end
  end

  # GET /job_applications/1/edit
  def edit
    @job_application = JobApplication.find(params[:id])
  end

  # POST /job_applications
  # POST /job_applications.json
  def create
    @job_application = JobApplication.new(params[:job_application])
    @vacancy = Vacancy.find_by_id(params[:vacancy_id]);
    if user_signed_in? && !current_user.admin?
      applicant = Applicant.find_by_id(current_user.id)
      @job_application.applicant_id = current_user.id
      @job_application.vacancy_id = @vacancy.id
    end
    
    respond_to do |format|
      if @job_application.save
        format.html { redirect_to @vacancy, notice: 'Job application was successfully created.' }
        format.json { render json: @job_application, status: :created, location: [applicant, @job_application] }
      else
        format.html { render action: "new" }
        format.json { render json: @job_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /job_applications/1
  # PUT /job_applications/1.json
  def update
    @job_application = JobApplication.find(params[:id])

    respond_to do |format|
      if @job_application.update_attributes(params[:job_application])
        format.html { redirect_to vacancy_path(@job_application.vacancy_id), notice: 'Job application was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_applications/1
  # DELETE /job_applications/1.json
  def destroy
    @job_application = JobApplication.find(params[:id])
    @job_application.destroy

    respond_to do |format|
      format.html { redirect_to job_applications_url }
      format.json { head :no_content }
    end
  end

  def rate_as_good
    @job_application = JobApplication.find(params[:id])
    vacancy = @job_application.vacancy
    @job_application.mark_as_good
    assignment = JobAssignment.find_by_job_application_id(@job_application.id)
    assignment.reviewed = true
    assignment.save
    ApplicationNotifier.reviewed_application(current_user, vacancy, @job_application.user).deliver


    redirect_to admin_job_applications_path, notice: "Reviewed the application from #{@job_application.user.fullname} for #{@job_application.vacancy.title} as good"
  end

  def rate_as_bad
    @job_application = JobApplication.find(params[:id])
    vacancy = @job_application.vacancy
    @job_application.mark_as_bad
    assignment = JobAssignment.find_by_job_application_id(@job_application.id)
    assignment.reviewed = true
    assignment.save
    ApplicationNotifier.bad_reviewed_application(current_user, vacancy, @job_application.user).deliver

    redirect_to admin_job_applications_path , notice: "Reviewed the application from #{@job_application.user.fullname} for #{@job_application.vacancy.title} as bad"
  end

  def reject
    @job_application = JobApplication.find(params[:id])
    vacancy = @job_application.vacancy
    @state = @job_application.state
    @job_application.reject
    @job_application.save!
    ApplicationNotifier.rejected_application(vacancy, @job_application.user).deliver

    respond_to do |format|
      format.html {redirect_to admin_job_application_path(vacancy.id), notice: "Rejected the application from #{@job_application.user.fullname} for #{@job_application.vacancy.title}"}
      format.js
    end
  end

  def employ
    @job_application = JobApplication.find(params[:id])
    vacancy = @job_application.vacancy
    @job_application.employ
    @job_application.save!
    ApplicationNotifier.accepted_application(vacancy, @job_application.user).deliver
    # ApplicationNotifier.accepted_application_moderator(vacancy, @job_application.user).deliver

    redirect_to admin_job_application_path(vacancy.id), notice: "Employed #{@job_application.user.fullname} for #{@job_application.vacancy.title}"
  end

  def select_moderator
    @job_application = JobApplication.find(params[:id])
    @assignment = JobAssignment.new()

    respond_to do |format|
      format.html
      format.js
    end
  end
end
