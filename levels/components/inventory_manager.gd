extends Node
class_name InventoryManager

@export var items: Array[ItemData] = []
var index: int = 0

var item_ui: InvSlot
var player: CharacterBody2D

func _ready():
	SignalBus.inv_updated.connect(_on_inv_update)

func _setup_lvl(p_ref):
	item_ui = p_ref.item_ui
	player = p_ref.player
	
	item_ui._enable_scroll(false)
	item_ui._enable_count(false)
	var unlocks = Inventory.get_unlocked_items()
	if unlocks.size() > 0:
		_change_slot(1)
		item_ui._enable_count(true)
	if unlocks.size() > 1:
		item_ui._enable_scroll(true)

func _change_slot(direction: int):
	index += direction
	if index > items.size() - 1: index = 0
	if index < 0: index = items.size() - 1
	var current_item = items[index].item_name

	if not Inventory.items[current_item].unlocked:
		_change_slot(direction)
		
	_update_ui()

func _on_inv_update():
	if Inventory.get_unlocked_items().size() == 1:
		_change_slot(1)
		return
	_update_ui()
	
func _update_ui():
	if Inventory.get_unlocked_items().size() <= 0:
		return
	item_ui._enable_count(true)
	var current_item = items[index].item_name
	var item_texture = items[index].texture
	item_ui.set_item_ui(item_texture)
	item_ui._update_label(Inventory.items[current_item].current)
	if Inventory.items[current_item].current <= 0:
		item_ui.set_modulation(true)
	else:
		item_ui.set_modulation(false)

func _spawn_in_hand(item_scene):
	var item = item_scene.instantiate()
	item.global_position = player.global_position
	item.in_picked_state()
	SignalBus.spawned.emit(item) # To add to items scene
	player.call_deferred("spawn_in_hand", item) # For player to grab

func item_clicked():
	if not is_instance_valid(player): return # Player is dead

	var current_item = items[index].item_name
	var item_scene = items[index].item_scene
	if Inventory.items[current_item].current > 0:
		_spawn_in_hand(item_scene)
		Inventory.items[current_item].current -= 1
	_update_ui()
