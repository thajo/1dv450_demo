class AddIndexToNameOnPlayer < ActiveRecord::Migration
  def change
    add_index :players, :name
  end
end
