class TeamsController < ApplicationController
  def team_name
    @team = Team.where(nickname: :name)
    render :json => @team
  end
  
  def team_players
    @players = Team.find(params[:id]).players
    render :json => @players
  end
  
  def index
    @teams = Team.all
    render json: @teams
  end
end
