class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
  def verify_admin
    unless user_signed_in? && current_user.admin?
      flash[:error] = "You don't have permission." 
      redirect_to root_url
    end
  end
end
