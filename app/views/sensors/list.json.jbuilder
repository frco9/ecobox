json.array!(@sensors) do |sensor|
	json.name sensor.name
	if !sensor.is_activated
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
	json.color 'palette.color()'
end