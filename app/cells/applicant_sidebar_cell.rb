class ApplicantSidebarCell < Cell::Rails

  def display(args)
    user = args[:user]
    @applications = user.job_applications
    
    render
  end

end
