json.series(@sensors) do |sensor|
	json.name "#{sensor.name} - #{DataType.find(sensor.data_type_id).name}"
	if !SensorsDataType.find_by(sensor_id: sensor.id, data_type_id: sensor.data_type_id).is_activated
		json.data (Array(1..1)) do |index|
			json.x DateTime.now.to_i
			json.y 0
		end
		json.is_data false
		json.disabled true
	else
		json.is_data true
		json.disabled false
	end
	json.id sensor.id
	json.data_type_id sensor.data_type_id
	json.color 'palette.color()'
	json.renderer DataType.find(sensor.data_type_id).graph_render
	json.minDate @minDate.shift.try(:created_at)
	json.maxDate @maxDate.shift.try(:created_at)
end