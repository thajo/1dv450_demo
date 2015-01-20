require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "should get team by URL" do
    get :team_name , {name: "spurs"}
    assert_response :success
    assert_not_nil assigns(:team)
  end
  
  # try the url /teams/1/players
  test "should get players in team" do 
    get :team_players, {id: 1}
    assert_response :success
    assert_not_nil assigns(:players)
  end
end
