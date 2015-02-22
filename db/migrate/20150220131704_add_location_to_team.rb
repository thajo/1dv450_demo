class AddLocationToTeam < ActiveRecord::Migration
  def change
  	add_column :teams, :address, :string
  	add_column :teams, :longitude, :float
  	add_column :teams, :latitude, :float
  end
end
