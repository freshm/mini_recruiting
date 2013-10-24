class GuestApplyController < ApplicationController
  def new
    @vacancy = Vacancy.find_by_id(params[:vacancy_id])
    @applicant = Applicant.new
    @applicant.job_applications.new(vacancy_id: @vacancy.id)
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: [@applicant, @job_application] }
    end
  end
  
  def create
    @vacancy = Vacancy.find_by_id(params[:vacancy_id])
    job = params[:user].delete("job_application")
    @applicant = Applicant.new(params[:user])
    
    
    #@applicant.job_application.create()
    #@vacancy.job_applications.create(applicant_id: @applicant.id)

    respond_to do |format|
      if @applicant.save
        unless @vacancy == nil
          @job_application = @applicant.job_applications.create(job.merge vacancy_id: @vacancy.id)
          if @job_application.save
            format.html { redirect_to root_path, notice: 'Welcome! You have signed up and applied successfully for this vacancy.' }
            format.json { render json: @applicant, status: :created, location: @applicant }
            sign_in(:user, @applicant)
          end
        else
            format.html { redirect_to root_path, notice: 'Welcome! You have signed up but your application could not be proccessed.' }
            format.json { render json: @applicant, status: :created, location: @applicant }
            sign_in(:user, @applicant)
        end
      else
        format.html { render action: "new" }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end
end