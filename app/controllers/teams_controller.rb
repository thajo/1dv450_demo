class TeamsController < ApplicationController
  
  respond_to :xml, :json, :html
  
  def index
    @teams = Team.all
  end
  
  def show
    @team = Team.find(params[:id])
    @players = @team.players
    respond_with @team
  end
end
