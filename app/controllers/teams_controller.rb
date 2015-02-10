class TeamsController < ApplicationController
  
  respond_to :xml, :json
  
  # A better way to catch all the errors - Directing it to a private method
  rescue_from ActionController::UnknownFormat, with: :raise_bad_format
  
  # This is for testing authentication with JSON Web Token
  #before_action :api_authenticate, only: [:show]

  def index
    @teams = Team.all
    respond_with @teams
  end
  
  def show
    @team = Team.find(params[:id])
    @players = @team.players
    respond_with @team
    
    # If the record/resource is not found, we should give the API user a 404 back!
    # One way is using the rescue, another is using rescue_from (see above)
    rescue ActiveRecord::RecordNotFound
    # Using a custom error class for handling all my errors
      @error = ErrorMessage.new("Could not find that resource. Are you using the right team_id?", "The Team was not found!" )
      # See documentation for diffrent status codes
      respond_with  @error, status: :not_found
    
  end
  
  
  ### Private methods
  private
  
  def raise_bad_format
    
    @error = ErrorMessage.new("The API does not support the requested format?", "There was a bad call. Contact the developer!" )
      # See documentation for diffrent status codes
    render json: @error, status: :bad_request
  end
  
  
end

# This is a custom class for handling errors - Should be in another file!?!
class ErrorMessage
  
  def initialize(dev_mess, usr_mess)
    @developer_message = dev_mess
    @user_message = usr_mess
  end
  
  # This is a custom class so we dont have the xml serializer included. 
  # I wrote an own to_xml (will be called by framework)
  # There is probobly a gem for that!?!
  def to_xml(options={})
    str = "<error>"
    str += "  <developer_message>#{@developer_message}</developer_message>"
    str += "  <user_messages>#{@user_message}</user_messages>"
    str += "</error>"
  end
  
end
