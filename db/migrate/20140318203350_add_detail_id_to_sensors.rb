class AddDetailIdToSensors < ActiveRecord::Migration
  def change
    add_column :sensors, :detail_id, :integer
  end
end
