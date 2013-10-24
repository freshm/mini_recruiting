class SessionsController < Devise::SessionsController
  def new
    super
  end
  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    if resource.type == "Admin"
      respond_with resource, :location => admin_root_path
    elsif resource.type == "Moderator"
      respond_with resource, :location => admin_job_applications_path
      
    else
      respond_with resource, :location => after_sign_in_path_for(resource)
    end
  end
end