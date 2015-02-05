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
  
  
  
  ####### API auth stuff
  
  
  def api_authenticate 
    
    if request.headers["Authorization"].present?
      auth_header = request.headers['Authorization'].split(' ').last
      if !decodeJWT auth_header
        render json: { error: 'Bad format for token' }, status: :unauthorized 
      end
    else
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end
  
  def encodeJWT(user, exp=2.hours.from_now)
    # add the expire to the payload, as an integer
    payload = { user_id: user.id }
    payload[:exp] = exp.to_i
    
    # Encode the payload whit the application secret, and a more advanced hash method
    JWT.encode( payload, Rails.application.secrets.secret_key_base, "HS512")
  end
  
  def decodeJWT(token)
    puts "trie to decode"
    payload = JWT.decode(token, Rails.application.secrets.secret_key_base, "HS512")
   
    if payload[0]["exp"] >= Time.now.to_i
      payload
    else
      pust "time fucked up"
      false
    end
    # catch the error if token is wrong
    rescue
      puts "decoding fucked up"
      nil
   
  end
end
