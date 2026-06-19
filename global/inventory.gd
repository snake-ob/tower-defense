extends Node

var items: Dictionary = {
	'bombs': {'unlocked': true, 'max': 5, 'current': 5},
	'caltropes': {'unlocked': false, 'max': 5, 'current': 5},
	'landmines': {'unlocked': true, 'max': 5, 'current': 5},
	'walls': {'unlocked': false, 'max': 5, 'current': 5},
}

func _ready():
	_debug_items()

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

func _debug_items() -> void:
	for key in items:
		var item = items[key]
		item.unlocked = true
		item.max = 5
		item.current = 5
