json.selected_data do | j |
	j.array!(@selected_data) do |selected_data|
		j.array!(selected_data) do |data|
		  j.date data.created_at.to_s(:db)
			j.set!(data.sensor_id, data.value) 
		end
	end
end
