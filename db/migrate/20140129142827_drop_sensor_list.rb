class DropSensorList < ActiveRecord::Migration
  def change
    drop_table :sensor_lists
  end
end
