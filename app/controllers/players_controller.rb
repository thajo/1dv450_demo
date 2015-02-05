class PlayersController < ApplicationController
  # before_action is a validation callback that protects some of the actions
  before_action :check_user, only: [:new, :create]
  before_action :set_cache_buster, only: [:new, :create]
  
 
  
  # This is called with /teams/:id/players som we must get the team  
  def index
    @team = Team.find(params[:team_id])
    @team_players = @team.players
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
