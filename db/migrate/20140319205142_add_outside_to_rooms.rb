class AddOutsideToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :outside, :boolean
  end
end
