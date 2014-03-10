class RemoveIsActivatedToSensors < ActiveRecord::Migration
  def change
    remove_column :sensors, :is_activated, :boolean
  end
end
