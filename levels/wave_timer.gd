extends Timer


func _get_remaining_time(delta):
	var minutes = int(ceil(time_left)) / 60
	var seconds = int(ceil(time_left)) % 60
	
	return "%d:%02d" % [minutes, seconds]
