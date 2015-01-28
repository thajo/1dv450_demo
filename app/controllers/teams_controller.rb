class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end
  
  def show
    @team = Team.find(params[:id])
    @players = @team.players
  end
end
