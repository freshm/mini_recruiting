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
end
