class GuestApplyController < ApplicationController
  def new
    @advertisement = Advertisement.find_by_id(params[:advertisement_id])
    @applicant = Applicant.new
    @applicant.job_applications.new(advertisement_id: @advertisement.id)
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: [@applicant, @job_application] }
    end
  end
  
  def create
    @advertisement = Advertisement.find_by_id(params[:advertisement_id])
    job = params[:user].delete("job_application")
    @applicant = Applicant.new(params[:user])
    
    
    #@applicant.job_application.create()
    #@advertisement.job_applications.create(applicant_id: @applicant.id)

    respond_to do |format|
      if @applicant.save
        unless @advertisement == nil
          @job_application = @applicant.job_applications.create(job.merge advertisement_id: @advertisement.id)
          if @job_application.save
            format.html { redirect_to root_path, notice: 'Welcome! You have signed up and applied successfully for this advertisement.' }
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