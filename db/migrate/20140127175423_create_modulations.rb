class CreateModulations < ActiveRecord::Migration
  def change
    create_table :modulations do |t|
      t.string :name
    end
  end
end
