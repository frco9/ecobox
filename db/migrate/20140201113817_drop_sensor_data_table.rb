class DropSensorDataTable < ActiveRecord::Migration
  def up
    drop_table :sensor_data
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
