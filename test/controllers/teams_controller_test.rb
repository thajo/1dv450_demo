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
    assert_equal body[0]["name"], Team.first.name
  end
  
  test "should get team by URL" do
    # test the routing 
    assert_routing '/teams/spurs', { controller: "teams", action: "team_name", name: "spurs" }
    #get :team_name , {name: "spurs"}
    #assert_response :success
   # assert_not_nil assigns(:team)

    
  
  end
  
 
end

# http://railsguides.net/belongs-to-and-presence-validation-rule1/