class CreateSensors < ActiveRecord::Migration
  def change
    create_table :sensors do |t|
      t.float :frequency
      t.string :name
      t.references :modulation, index: true
      t.references :room, index: true

      t.timestamps
    end
  end
end
