class TeamsController < ApplicationController
  
  respond_to :json, :xml
  
  # A better way to catch all the errors - Directing it to a private method
  rescue_from ActionController::UnknownFormat, with: :raise_bad_format
  
  # This is for testing authentication with JSON Web Token
 # before_action :api_authenticate, only: [:index]

  
  before_filter :sanitize_page_params

  NR_OF_RESOURCES = 20
  ########################### ACTIONS

  def index
    
    # set init values
    offset = 0
    limit = NR_OF_RESOURCES
    
    # du we have the parameters? Then set them   
    if params[:offset].present? && params[:limit].present?
      offset  = params[:offset]
      limit = params[:limit]
    end
    
    # Use limit and offset in the query
    # This makes a smarter query where players are included in the question 
    @teams = Team.limit(limit).offset(offset).includes(:players)
    respond_with @teams
  end
  
  
  def show
    @team = Team.find(params[:id])
    # @players = @team.players  ## This was for the html view
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
    
   

  def sanitize_page_params
    params[:offset] = params[:offset].to_i
    params[:limit] = params[:limit].to_i
  end
  
  def raise_bad_format
    @error = ErrorMessage.new("The API does not support the requested format?", "There was a bad call. Contact the developer!" )
    # See documentation for diffrent status codes
    render json: @error, status: :bad_request
  end
  
  
end

# This is a custom class for handling errors - Should be in another file!?!
# No support from rails base model
class ErrorMessage
  
  def initialize(dev_mess, usr_mess)
    # This is going to be json...camelcase
    @developerMessage = dev_mess
    @userMessage = usr_mess
  end
  
  # This is a custom class so we dont have the xml serializer included. 
  # I wrote an own to_xml (will be called by framework)
  # There is probably a gem for that!?!
  def to_xml(options={})
    str = "<error>"
    str += "  <developerMessage>#{@developerMessage}</developerMessage>"
    str += "  <userMessage>#{@userMessage}</userMessage>"
    str += "</error>"
  end
  
end
