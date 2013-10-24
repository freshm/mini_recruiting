class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
  
  protected
  
  def verify_admin
    unless user_signed_in? && current_user.admin?
      flash[:error] = "You have no power here!" 
      redirect_to root_url
    end
  end

  def verify_mod_privilges
    unless user_signed_in? && current_user.admin? || current_user.type == "Moderator"
      flash[:error] = "You have no power here!" 
      redirect_to root_url
    end
  end
    
end
