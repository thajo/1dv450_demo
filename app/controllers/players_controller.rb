class PlayersController < ApplicationController
  
  def index
    @team = Team.find(params[:team_id])
    @team_players = @team.players
  end
end
