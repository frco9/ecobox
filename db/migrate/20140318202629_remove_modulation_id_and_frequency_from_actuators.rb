class RemoveModulationIdAndFrequencyFromActuators < ActiveRecord::Migration
  def change
    remove_column :actuators, :modulation_id, :integer
    remove_column :actuators, :frequency, :float
  end
end
