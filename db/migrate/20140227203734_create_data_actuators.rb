class CreateDataActuators < ActiveRecord::Migration
  def change
    create_table :data_actuators do |t|
      t.float :value
      t.integer :actuator_id
      t.integer :data_type_id

      t.timestamps
    end
  end
end
