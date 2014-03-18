class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.string :name
      t.integer :modulation_id
      t.float :frequency

      t.timestamps
    end
  end
end
