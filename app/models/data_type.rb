class DataType < ActiveRecord::Base
  has_many :sensors_data_types
  has_many :sensors, :through => :sensors_data_types
end
