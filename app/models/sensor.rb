class Sensor < ActiveRecord::Base
  validates :hardware_address, presence: true

  belongs_to :detail
  belongs_to :room
  has_many :sensors_data_types, :dependent => :delete_all
  has_many :data_sensors, :dependent => :delete_all
  has_many :data_types, :through => :sensors_data_types

  def self.genSensorList(selected_data, sensor)
    tab = ""
    selected_data.each do |data_sensor|
      tab += "{date: '#{data_sensor.created_at.to_s(:db)}', #{sensor.id}: #{data_sensor.value}}, "
    end
    tab = tab[0..-3]
  end
end
