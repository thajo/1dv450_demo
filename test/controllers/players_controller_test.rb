require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  
   # try the url /teams/1/players
  test "should get players in team through /teams/:team_id/players" do 
    assert_routing '/teams/1/players', { controller: "players", action: "index", team_id: "1" }
    get :index, {team_id: 1}
    assert_response :success
   
    assert_not_nil assigns(:team_players)
    assert_not_nil assigns(:team)
   
    assert assigns(:team_players).any?, "The team should have players" # check that it has stuff
   # puts Player.find(3).name
    assert_includes assigns(:team_players), Player.find(1), "ERROR: Should find first player in the collection"
    
     # test that we have a template view
    assert_template layout: "layouts/application"
    assert_template :index
    
    # test the view, title
    assert_select 'title', "All players for #{Team.find(1).name}"
    
    assert_select "h1", Team.find(1).name
    
    # Test view to check that we render a number of listitems
    assert_select "ul.teamlist" do
      assert_select "li", assigns(:team_players).count
    end
    
    # test that the view have a link back to all teams
    assert_select("a[href=/teams]")
    
   end
end
