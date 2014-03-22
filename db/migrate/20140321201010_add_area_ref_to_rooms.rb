class AddAreaRefToRooms < ActiveRecord::Migration
  def change
    add_reference :rooms, :area, index: true
  end
end
