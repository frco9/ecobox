class AddIsActivatedToSensorsDataType < ActiveRecord::Migration
  def change
    add_column :sensors_data_types, :is_activated, :boolean, default: false 
  end
end
