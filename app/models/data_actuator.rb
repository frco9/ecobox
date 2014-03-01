class DataActuator < ActiveRecord::Base
	belongs_to :actuator
	belongs_to :data_type
end
