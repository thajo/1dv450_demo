class CreateMatchesTeamsTable < ActiveRecord::Migration
  def change
    create_table :matches_teams, id: false do |t|
      t.belongs_to :match, index: true
      t.belongs_to :team, index: true
      
    end
  end
end
