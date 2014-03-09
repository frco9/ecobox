class CreateActuatorsDataTypes < ActiveRecord::Migration
  def change
    create_table :actuators_data_types do |t|
      t.integer :actuator_id
      t.integer :data_type_id

      t.timestamps
    end
  end
end
