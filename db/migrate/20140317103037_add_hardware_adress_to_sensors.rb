class AddHardwareAdressToSensors < ActiveRecord::Migration
  def change
  	add_column :sensors, :hardware_address, :string 
  end
end
