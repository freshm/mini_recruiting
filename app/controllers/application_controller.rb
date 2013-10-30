class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  def vacancy_generate_html_for_pdf(object)
    "<div class='row'>
          <img src='http://localhost:3000/assets/corporate-logo.png' />
          <h1>#{object[0].title}</h1>
          <hr/>
          <div class='content'>
            <p><label><b>Location: </b></label>#{object[0].location}</p><br />
            <p><label><b>Description: </b></label>#{object[0].description}</p><br />
            <p><label><b>Duties: </b></label>#{object[0].duties}</p><br />
            <p><label><b>Requirement: </b></label>#{object[0].requirement}</p><br />
            <hr />
            <p>#{object[1]}</p>
          </div>
    </div>"
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
