class PlayersController < ApplicationController
  # before_action is a validation callback that protects some of the actions
  #before_action :check_user, only: [:new, :create]
  #before_action :set_cache_buster, only: [:new, :create]


  # Should check that we got an API-key
  before_action :api_key

  # This is the perfered formats (OBS no HTML => no views loaded)
  respond_to :json, :xml

  def show
    # To get the right player-id I need to call the from_param (see model)
    #@player = Player.from_param(params[:id])

    # I map the Player directly against the primary key. Thats
    # mush easier
    @player = Player.find(params[:id])
    # serializable_hash in the Player-model will render the object
    respond_with @player
  end


  # This is called with /players
  def index
    # Use includes in the query for performance (lesser hits on DB)
    players = Player.limit(@limit).offset(@offset).includes(:team)

    # I want my client to know how many players the db has
    nr = Player.distinct.count(:id)

    # Put it all together in a hash
    @response = {players: players, nrOfPlayers: nr}
    # serializable_hash in the Player-model will render the object
    respond_with @response, status: :ok, location: players_path
  end

  # Called witha a POST to create the player via
  def create
    # The data is only in json-format in this example
    player = Player.new(player_params)    # using strong parameters

    if player.save
     # ok respond with the created object (team)
      respond_with  player, status: :created
    else
     # render or error message
      error = ErrorMessage.new("Could not create the resource. Bad parameters?", "Could not create the resource!" )
      render json: error, status: :bad_request # just json in this example
    end

  end



  private
    # Using a private method to encapsulate the permissible parameters is just a good pattern
    # since you'll be able to reuse the same permit list between create and update.
  def player_params
       # This is json
      json_params = ActionController::Parameters.new( JSON.parse(request.body.read) )
      json_params.require(:player).permit(:name, :age, :team_id)

    end
end
