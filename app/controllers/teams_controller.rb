class TeamsController < ApplicationController
  
  respond_to :xml, :json, :html
  
  # This is for testing authentication with JSON Web Token
  before_action :api_authenticate, only: [:show]

  def index
    @teams = Team.all
  end
  
  def show
    @team = Team.find(params[:id])
    @players = @team.players
    respond_with @team
  end
  
  
end
