extends Node
class_name InventoryManager

@export var items: Array[ItemData] = []
var index: int = 0

var item_ui: Node
var player: CharacterBody2D

func _setup_lvl(p_ref):
	item_ui = p_ref.item_ui
	player = p_ref.player
	_spawn_in_hand(items[0].item_scene)

func _change_slot(direction: int):
	index += direction
	if index > items.size(): index = 0
	_update_ui()
	
func _update_ui():
	var item_texture = items[index].texture
	item_ui.set_item_ui(item_texture)
	if items[index].current <= 0:
		item_ui.set_modulation(true)
	else:
		item_ui.set_modulation(false)

func _spawn_in_hand(item_scene):
	var item = item_scene.instantiate()
	item.in_picked_state()
	SignalBus.spawned.emit(item) # To add to items scene
	player.call_deferred("spawn_in_hand", item) # For player to grab
