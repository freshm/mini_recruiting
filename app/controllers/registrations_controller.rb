class RegistrationsController < Devise::RegistrationsController
  before_filter :check_permissions
  
  private
 
  def check_permissions
    authorize! :create, resource
  end
end