class CreateActuators < ActiveRecord::Migration
  def change
    create_table :actuators do |t|
      t.boolean :activated, default: false 
      t.float :frequency
      t.string :name
      t.integer :modulation_id
      t.integer :room_id

      t.timestamps
    end
  end
end
