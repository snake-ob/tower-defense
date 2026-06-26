extends Node

signal coin_added
var items: Dictionary = {
	'bombs': {'unlocked': false, 'max': 0, 'current': 0},
	'caltropes': {'unlocked': false, 'max': 0, 'current': 0},
	'landmines': {'unlocked': false, 'max': 0, 'current': 0},
	'walls': {'unlocked': false, 'max': 0, 'current': 0},
}
		

var wallet: int = 0

func _ready():
	#_debug_items() # Sets items to unlocked and 5 held
	SignalBus.coin_collected.connect(_on_coin_collect)

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
	wallet = 0

func _debug_items() -> void:
	for key in items:
		var item = items[key]
		item.unlocked = true
		item.max = 5
		item.current = 5

func upgrade(p_item: String):
	var item = items[p_item]
	item.unlocked = true
	item.max += 1
	item.current += 1
	SignalBus.inv_updated.emit()

func _on_coin_collect():
	wallet += 1
	coin_added.emit()
