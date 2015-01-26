class CrateJoinTableMatchTeams < ActiveRecord::Migration
  def change
    create_join_table :matches, :teams
  end
end
