module SensorsHelper
	def is_new?(sensor)
		!sensor.detail or !sensor.data_types
	end
end
