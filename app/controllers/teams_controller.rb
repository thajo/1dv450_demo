class TeamsController < ApplicationController

  respond_to :json, :xml

  # A better way to catch all the errors - Directing it to a private method
  rescue_from ActionController::UnknownFormat, with: :raise_bad_format

  # This is for testing authentication with JSON Web Token
  before_action :api_authenticate, only: [:create]
  before_action :api_key

  # Checking if user want own limit/offset - definied in application_controller
  # for wider reach
  before_action :offset_params, only: [:index, :nearby]


<<<<<<< HEAD
  
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
=======
  ########################### ACTIONS

  def index
    # @limit and @offset is set in application_controller
    # see before_Action obove
    teams = Team.limit(@limit).offset(@offset).includes(:players)


    # We also want to send out how many Teams we have in the db
    nr = Team.distinct.count(:id);
    # Buld a response variable
    @response = {teams: teams, nrOfTeams: nr}
    # also set location
    respond_with @response, status: :ok, location: teams_path
>>>>>>> some major updates going from web application to api in player- and team-controllers
  end


  def show
    @team = Team.find(params[:id])
<<<<<<< HEAD
    # @players = @team.players  ## This was for the html view
    respond_with @team
    
=======
    respond_with @team, location: teams_path(@team)

>>>>>>> some major updates going from web application to api in player- and team-controllers
    # If the record/resource is not found, we should give the API user a 404 back!
    # One way is using the rescue, another is using rescue_from (see above)
    rescue ActiveRecord::RecordNotFound
      # Using a custom error class for handling all my errors
      @error = ErrorMessage.new("Could not find that resource. Are you using the right team_id?", "The Team was not found!" )
      # See documentation for diffrent status codes
      respond_with  @error, status: :not_found

  end

  def create
    # This is a POST and should have a body with:
    # { "team":
    #  {
    #    "name": "John",
    #    "nickname": "test1",
    #    "latitude" : "32.324",
    #    "longitude" : "13.3243"
    #   }
    # }

    #new team with strong parameters
    team = Team.new(team_params)

    if team.save
      # ok respond with the created object (team)
      respond_with  team, status: :created
    else
      # render or error message
      error = ErrorMessage.new("Could not create the resource. Bad parameters?", "Could not create the resource!" )
      render json: error, status: :bad_request # just json in this example
    end



  end


  # This method is using the geocoder and helps with searching near a specific position
  def nearby

    # Check the parameters
    if params[:long].present? && params[:lat].present?

      # using the parameters and offset/limit
      t = Team.near([params[:lat].to_f, params[:long].to_f], 20).limit(@limit).offset(@offset)
      respond_with t, status: :ok
    else

      error = ErrorMessage.new("Could not find any resources. Bad parameters?", "Could not find any team!" )
      render json: error, status: :bad_request # just json in this example
    end

  end


################################# Private methods
  private
<<<<<<< HEAD
    
   

  def sanitize_page_params
    params[:offset] = params[:offset].to_i
    params[:limit] = params[:limit].to_i
  end
  
=======

>>>>>>> some major updates going from web application to api in player- and team-controllers
  def raise_bad_format
    @error = ErrorMessage.new("The API does not support the requested format?", "There was a bad call. Contact the developer!" )
    # See documentation for diffrent status codes
    render json: @error, status: :bad_request
  end


  # This is for strong parameters, im using json parameters in this example
  def team_params
    # This is json so i have to parse it - this is a flat structure
    json_params = ActionController::Parameters.new( JSON.parse(request.body.read) )
    json_params.require(:team).permit(:name, :nickname, :latitude, :longitude)
  end

end


################################### Custom class
# This is a custom class for handling errors - Should be in another file!
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
