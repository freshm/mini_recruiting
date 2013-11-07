module ApplicationHelper
  def applicant_sign_in_path?(path)
    if (path == "/applicants/sign_in" )
      true
    else
      false
    end
  end

  def admin_controller?(controller)
    controller == 'admin/users' or controller == 'admin/vacancies' or controller == 'admin/job_applications' or controller == 'admin/job_assignments'
  end
  
  def i18n_date(date)
     if request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first == "de" || "no" || "se"
         date.strftime("%d.%m.%Y %H:%M")
     elsif request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first == "en"
        date.strftime("%m/%d/%Y %-I:%m %p")
     elsif request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first == "fr"
        date.strftime("%d-%m-%Y %-I:%m %p")
     else
        date.strftime("%Y-%m-%d %H:%m")
     end
   end
  
  def admin_signed_in?
    user_signed_in? && current_user.admin?
  end

  def access_to_admin_area?
    user_signed_in? && current_user.admin? || current_user.type == "Moderator"
  end

  def moderator_signed_in?
    user_signed_in? && current_user.type = "Moderator"
  end
end