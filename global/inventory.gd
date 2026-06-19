extends Node

var items: Dictionary = {
	'bombs': {'unlocked': true, 'max': 1, 'current': 1},
	'caltropes': {'unlocked': false, 'max': 1, 'current': 1},
	'landmines': {'unlocked': true, 'max': 1, 'current': 1},
	'walls': {'unlocked': false, 'max': 1, 'current': 1},
}

func get_unlocked_items() -> Array:
	var unlocks: Array = []
	for key in items:
		var item = items[key]
		if item.unlocked:
			unlocks.append(item)
	return unlocks

func _reset_items() -> void:
	for key in items:
		var item = items[key]
		item.unlocked = false
		item.max = 0
		item.current = 0
