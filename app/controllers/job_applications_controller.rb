class JobApplicationsController < ApplicationController
  # GET /job_applications
  # GET /job_applications.json
  def index
    @job_applications = JobApplication.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @job_applications }
    end
  end

  # GET /job_applications/1
  # GET /job_applications/1.json
  def show
    @job_application = JobApplication.find(params[:id])
    @vacancy = Vacancy.find_by_id(@job_application.vacancy_id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job_application }
    end
  end

  # GET /job_applications/new
  # GET /job_applications/new.json
  def new
    @vacancy = Vacancy.find_by_id(params[:vacancy_id]);
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
end
