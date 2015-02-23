class SessionsController < ApplicationController
  protect_from_forgery :except => [:api_auth]
  
  def new
    # loads the login-form from the view sessions/new.html.erb
  end
  
  # called when a login attempt is made
  def create
    # Getting the user by mail
    user = User.find_by(email: params[:session][:email].downcase)
     
    # check if we got a user first and then the password is correct
    if user && user.authenticate(params[:session][:password])
      
      # call helper method log_in (se helpers/seesionhelper)
      log_in user
      # Log the user in and redirect to the page with all teams (/teams)
      redirect_to teams_path
    else
      # Create an error message.
      #flash.now is for rendering (lives for the cycle)
      # danger is mapped in the view against bootstraps classes
      flash.now[:danger] = 'Invalid email/password combination'
      # render the layout with the form
      render 'new'
    end
  end
  
   
  # called when logout
  def destroy
    log_out # called in sessionhelper
    # flash (without .now) lives for a redirect
    flash[:info] = "Tnx for the visit, welcome back!"
    redirect_to root_url # go back
  end
 
  ## This is called from a client who wish to authenticate and get a JSON Web Token back
   def api_auth 
      # output the APIkey from the header
      # puts request.headers["X-APIkey"]; 
      user = User.find_by(email: params[:email].downcase)
      if user && user.authenticate(params[:password])
        render json: { auth_token: encodeJWT(user) }
      else
        render json: { error: 'Invalid username or password' }, status: :unauthorized
      end
  end
  
end
