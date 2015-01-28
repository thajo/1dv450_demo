module SessionsHelper # OBS to use this helper include it in ApplicationController
  # creates a temporary encrypt cookie 
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # Remove all about the session, put current_user to nil
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  # Fetch and returns the current user
  def current_user
    # if current_user is et use it otherwise ask the data store
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def is_logged_in?
    # is the current_user logged in - returns true 
    !current_user.nil?
  end
  
  def check_user
    unless is_logged_in?
      flash[:danger] = "Do log in!"
      redirect_to login_path
    end
  end
  
end
