require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "Should list teams (GET /teams) in json format" do
    assert_routing '/teams', { controller: "teams", action: "index"}
    get :index
    assert_response :success
    body = JSON.parse(response.body)
  #  puts body[0]
    assert_equal body[0]["name"], Team.first.name
  end
  
  test "should get team by URL" do
    assert_routing '/teams/spurs', { controller: "teams", action: "team_name", name: "spurs" }
    get :team_name , {name: "spurs"}
    assert_response :success
    assert_not_nil assigns(:team)
  end
  
  # try the url /teams/1/players
  test "should get players in team" do 
    assert_routing '/teams/1/players', { controller: "teams", action: "team_players", id: "1" }
    get :team_players, {id: 1}
    assert_response :success
    assert_not_nil assigns(:players)
    assert assigns(:players).any?, "The team should have players" # check that it has stuff
    assert assigns(:players).includes(Player.first), "ERROR: Should find first player in the collection"
  #  assert_equal @players.size, 2
  end
end

# http://railsguides.net/belongs-to-and-presence-validation-rule1/