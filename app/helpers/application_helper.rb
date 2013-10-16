module ApplicationHelper
  def applicant_sign_in_path?(path)
    if (path == "/applicants/sign_in" )
      true
    else
      false
    end
  end
  
  def admin_signed_in?
    if user_signed_in? && current_user.admin?
      true
    else
      false
    end
  end
end
