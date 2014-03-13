class SensorsDataType < ActiveRecord::Base
  belongs_to :sensor
  belongs_to :data_type
  self.primary_key = :sensor_id
end
