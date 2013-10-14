module UsersHelper
  def admin_signed_in?
    if user_signed_in? && current_user.admin?
      true
    else
      false
    end
    
  end
end
