require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "Should list teams (GET /teams)" do
    assert_routing '/teams', { controller: "teams", action: "index"}  #check the route
    get :index # check that the action exists
    
    assert_response :success
    assert_not_nil assigns(:teams) # check that we assigns @team
    
    assert_equal assigns(:teams).first.nickname.downcase, "spurs" # check some data, controlled by fixures
  end
  
  test "should show a single team" do
    assert_routing '/teams/1', { controller: "teams", action: "show", id: 1}  #check the route
    get :show
    assert_response :success
    assert_not_nil assigns(:team)
  end
  
  
 
end

# http://railsguides.net/belongs-to-and-presence-validation-rule1/