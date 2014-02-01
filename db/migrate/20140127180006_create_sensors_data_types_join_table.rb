class CreateSensorsDataTypesJoinTable < ActiveRecord::Migration
  def self.up
    create_table :sensors_data_types, :id => false do |t|
      t.references :sensor, :data_type # Pour créer les clés etrangères
    end
    add_index :sensors_data_types, [:sensor_id, :data_type_id] # Optionnel
  end
  def self.down
    drop_table :sensors_data_types
  end
end
