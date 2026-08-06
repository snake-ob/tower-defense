extends Node
class_name PersistentData

var towers: Array[Dictionary]

func _ready():
	reset_towers()

func reset_towers():
	var crypto = Crypto.new()
	
	towers = [
		{
			"runes": [],
			"id": crypto.generate_random_bytes(16).hex_encode()
		},
		{
			"runes": [],
			"id": crypto.generate_random_bytes(16).hex_encode()
		}
	]

func update_tower(_id: String, _runes: Array):
	for tower in towers:
		if _id == tower.id:
			tower.runes = _runes
			return
		
	print("Tower with id '", _id, "' not found.")
