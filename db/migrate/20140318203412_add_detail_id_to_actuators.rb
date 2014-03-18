class AddDetailIdToActuators < ActiveRecord::Migration
  def change
    add_column :actuators, :detail_id, :integer
  end
end
