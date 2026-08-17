extends Node

signal coin_added

var items: Dictionary = {
	'bombs': {'unlocked': false, 'max': 0, 'current': 0},
	'caltropes': {'unlocked': false, 'max': 0, 'current': 0},
	'landmines': {'unlocked': false, 'max': 0, 'current': 0},
	'walls': {'unlocked': false, 'max': 0, 'current': 0},
}
		

var wallet: int = 0
@export var debug_upgrades: Array = [
	preload("res://entities/tower/gems/FireGem.tscn"),
	preload("res://entities/tower/gems/IceGem.tscn"),
	preload("res://entities/tower/gems/PoisonGem.tscn"),
	preload("res://entities/tower/gems/SpeedGem.tscn"),
	preload("res://entities/tower/gems/AttackGem.tscn"),
	preload("res://pickups/BombUpgrade.tscn"),
	preload("res://pickups/CaltropeUpgrade.tscn"),
	preload("res://pickups/LandmineUpgrade.tscn"),
	preload("res://entities/tower/Tower.tscn"),
	preload("res://pickups/WallUpgrade.tscn")
]


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
	
func reload_items() -> void:
	for key in items:
		var item = items[key]
		item.current = item.max
	SignalBus.inv_updated.emit()
	

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
	var coin_sound = load("res://audio/sfx/pickup_coin.wav")
	Sound.play_iso_SFX(coin_sound)
	
func _unhandled_input(event):
	var is_modifier_pressed = event.ctrl_pressed or event.meta_pressed

	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_B and is_modifier_pressed:
			var random_upgrade = debug_upgrades.pick_random()
			var upgrade = random_upgrade.instantiate()
			upgrade.global_position = Vector2.ZERO
			if upgrade is Tower:
				upgrade.register_tower()
			SignalBus.spawned.emit(upgrade)
			SignalBus.inv_updated.emit()
		elif event.keycode == KEY_C and is_modifier_pressed:
			wallet += 10
			coin_added.emit()
			
