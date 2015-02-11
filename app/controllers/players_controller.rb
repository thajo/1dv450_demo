class PlayersController < ApplicationController
  # before_action is a validation callback that protects some of the actions
  before_action :check_user, only: [:new, :create]
  before_action :set_cache_buster, only: [:new, :create]
 # before_action :set_self_url
  respond_to :xml, :json
 
  def show
    # To get the right player-id I need to call the from_param (see model)
    @player = Player.from_param(params[:id])
    respond_with @player
  end
  
  
  # This is called with /teams/:id/players som we must get the team  
  def index
    # this action is called from two URLs (/teams/id/players) and (/players) with diffrent meanings
    # its just one parameter to check so i find it OK to do this and not separate the code in diffrent methods
    if params[:team_id].present?
      @team = Team.find(params[:team_id])
      @players = @team.players
    else
      @players = Player.all
    end
  end
  
  # Called to create a new player
  def new
    
    @player = Player.new
  end
  
  # Called witha a POST to create the player
  def create
    @player = Player.new(player_params)    # using strong parameters
    
    if @player.save
      # When player is created i will redirect user to a page that list all players in the team 
      # /teams/:id/players
      redirect_to team_players_path(@player.team_id)
    else
      # just render the new.html.erb template (holding the form - should give us error messages)
      render 'new'
    end
  end
  
  
  
  private
    # Using a private method to encapsulate the permissible parameters is just a good pattern
    # since you'll be able to reuse the same permit list between create and update. 
  def player_params
      params.require(:player).permit(:name, :age, :team_id)
    end
end
