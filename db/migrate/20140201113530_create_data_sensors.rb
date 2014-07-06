class CreateDataSensors < ActiveRecord::Migration
  def change
    create_table :data_sensors do |t|
      t.float :value
      t.references :sensor, index: true
      t.references :data_type, index: true

      t.timestamps
    end
  end
end
