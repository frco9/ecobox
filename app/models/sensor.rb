class Sensor < ActiveRecord::Base
  belongs_to :modulation
  belongs_to :room
  has_many :data_sensors
  has_and_belongs_to_many :data_types
end
