module SensorsHelper
	def is_new?(sensor)
		!sensor.try(:name)
	end

  def is_unknown?(sensor)
    !sensor.try(:detail)
  end
end
