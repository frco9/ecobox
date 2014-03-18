class RemoveModulationIdAndFrequencyFromSensors < ActiveRecord::Migration
  def change
    remove_column :sensors, :modulation_id, :integer
    remove_column :sensors, :frequency, :float
  end
end
