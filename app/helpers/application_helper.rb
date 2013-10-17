module ApplicationHelper
  def applicant_sign_in_path?(path)
    if (path == "/applicants/sign_in" )
      true
    else
      false
    end
  end
  
  def beutified_date(date)
    "#{date.year}-#{date.month}-#{date.day} #{date.hour}:#{date.min}"
  end
  
  def admin_signed_in?
    user_signed_in? && current_user.admin?
  end
end
