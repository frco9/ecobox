class DropSensor < ActiveRecord::Migration
  def change
    drop_table :sensors
  end
end
