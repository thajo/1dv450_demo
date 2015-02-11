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
  
  
  
  ####### API auth stuff with JWT
  
  # This is a callback which actiosn will call if protected
  def api_authenticate 
    if request.headers["Authorization"].present?
      # Take the last part in The header (ignore Bearer)
      auth_header = request.headers['Authorization'].split(' ').last
      # Are we feeling alright!?
      @token_payload = decodeJWT auth_header
      if !@token_payload
        render json: { error: 'The provided token wasn´t correct' }, status: :bad_request 
      end
    else
      render json: { error: 'Need to include the Authorization header' }, status: :forbidden # The header isn´t present
    end
  end
  
  # This method is for encoding the JWT before sending it out
  def encodeJWT(user, exp=2.hours.from_now)
    # add the expire to the payload, as an integer
    payload = { user_id: user.id }
    payload[:exp] = exp.to_i
    
    # Encode the payload whit the application secret, and a more advanced hash method (creates header with JWT gem)
    JWT.encode( payload, Rails.application.secrets.secret_key_base, "HS512")
  end
  
  # When we get a call we have to decode it - Returns the payload if good otherwise false
  def decodeJWT(token)
   
    payload = JWT.decode(token, Rails.application.secrets.secret_key_base, "HS512")
   
    if payload[0]["exp"] >= Time.now.to_i
      payload
    else
      puts "time fucked up"
      false
    end
    # catch the error if token is wrong
    rescue
      puts "decoding fucked up"
      nil
  end
end
