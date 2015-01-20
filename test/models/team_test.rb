require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "Should not save a team without a name" do
    t = Team.new
    t.nickname = "testNick"
    assert_not t.save, "ERROR: Test says we can save an empty team"
  end
  
  test "Save a team with a name" do
    t = Team.new
    t.name = "Tottenham Hotspur FC"
    assert t.save
  end
  
  # Test for specific method
  test "should return an infotext" do
    team = Team.new
    team.name = "Testteam"
    team.nickname = "tessty"
    assert_equal team.info, "Testteam is called tessty"
  end
  
  ## Stupid tests
  test "Should delete a team" do 
   
    assert_difference('Team.count', difference = -1) do
      t = Team.first
      t.delete
    end
  end
  
  
  test "Should read the first teams name (from fixure)" do
    t = Team.first #Team.find(1)
    assert_equal t.name, "Tottenham Hotspur FC" 
  end
  
  
end
