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
   
  # This test is used for testing
  test "Should have players (relation to Player object)" do
    assert Team.first.players
  end
  
  
  ## Added these test in F03 #################
  
  # cascade delete
  test "Removing a team should remove all players" do
    assert_difference('Player.count', difference = -2) do
      t = Team.find(1)
      t.destroy # use destroy not delete
      #puts Player.count
    end
  end
  
  # Test for specific method
  test "should return an infotext" do
    team = Team.new
    team.name = "Testteam"
    team.nickname = "tessty"
    assert_equal team.info, "Testteam is called tessty"
  end
  
  
  
end
