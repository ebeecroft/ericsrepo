class ApplicationController < ActionController::Base
  protect_from_forgery
  include CurrentGroupeeHelper

  helper_method :current_groupee

  def check_login
     unless logged_in?
        redirect_to "/login"
     end
  end

  def logged_in?
     if session[:groupee_id]
        "I am true and not false"
        return true
     else
        "I am not set and have no id"
        return false
     end
  end

  def redirect_back_or(default)
     redirect_to(session[:groupee_id] || default)
  end
end
