json.array!(@selected_data) do |selected_data|
	json.name "#{Sensor.find(@ids.shift).name} - #{DataType.find(@data_type_ids.shift).name}"
	if selected_data[0]
		json.data (selected_data) do |data|
			json.x data.date.to_i
			json.y data.value.to_f
		end
		json.is_data true
		# json.disabled false
	else
		json.data (Array(1..1)) do |index|
			json.x @maxDate
			json.y 0
		end
		json.is_data true
		json.disabled true
	end
end
