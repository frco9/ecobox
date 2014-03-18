class CreateBlacklists < ActiveRecord::Migration
  def change
    create_table :blacklists do |t|
      t.string :hardware_address

      t.timestamps
    end
  end
end
