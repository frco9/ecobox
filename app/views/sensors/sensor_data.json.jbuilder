i=0
# json.all_data (@selected_data) do |j, selected_data|
json.array!(@selected_data) do |selected_data|
	json.name @sensors[i].name
	# j.color "palette.color(#{@sensors[i].name})"
	json.data (selected_data) do |data|
		json.x data.date.to_i
		json.y data.value.to_f
	end
	i += 1
end
