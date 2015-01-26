class CreateMatchesTeamsTable < ActiveRecord::Migration
  def change
    create_table :matches_teams, id: false do |t|
      t.belongs_to :matches, index: true
      t.belongs_to :teams, index: true
      
    end
  end
end
