class Sensor < ActiveRecord::Base
	validates :name, presence: true, uniqueness: { case_sensitive: false }
	validates :frequency, presence: true
	validates :modulation_id, presence: true
	validates :room_id, presence: true

  belongs_to :modulation
  belongs_to :room
  has_many :sensors_data_types
  has_many :data_sensors
  has_many :data_types, :through => :sensors_data_types

  def self.genSensorList(selected_data, sensor)
    tab = ""
    selected_data.each do |data_sensor|
      tab += "{date: '#{data_sensor.created_at.to_s(:db)}', #{sensor.id}: #{data_sensor.value}}, "
    end
    tab = tab[0..-3]
  end
end
