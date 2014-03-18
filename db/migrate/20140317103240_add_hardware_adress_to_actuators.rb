class AddHardwareAdressToActuators < ActiveRecord::Migration
  def change
    add_column :actuators, :hardware_address, :string
  end
end
