class CreateSensorData < ActiveRecord::Migration
  def change
    create_table :sensor_data do |t|
      t.float :value
      t.references :sensor, index: true
      t.references :data_type, index: true

      t.timestamps
    end
  end
end
