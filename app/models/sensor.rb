class Sensor < ActiveRecord::Base
  belongs_to :modulation
  belongs_to :room
  has_many :data_sensors
  has_and_belongs_to_many :data_types

  def self.genSensorList(sensor)
    tab = ""
    sensor.data_sensors.each do |data_sensor|
      tab += "{date: '#{data_sensor.created_at}', #{sensor.name.mb_chars.downcase.to_s}: #{data_sensor.value}}, "
    end
    tab = tab[0..-3]
  end
end
