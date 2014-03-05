class AddIsActivatedToSensors < ActiveRecord::Migration
  def change
    add_column :sensors, :is_activated, :boolean, default: false 
  end
end
