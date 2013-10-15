module ApplicationHelper
  def applicant_sign_in_path?(path)
    if (path == "/applicants/sign_in" )
      true
    else
      false
    end
    
  end
end
