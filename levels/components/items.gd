extends Node2D

var towers: Node2D

func _setup_lvl(p_ref):
	towers = p_ref.towers

func _ready():
	SignalBus.spawned.connect(_on_item_spawn)

func _on_item_spawn(item):
	var item_parent: Node2D = self
	if item is Tower:
		item_parent = towers
	item_parent.add_child.call_deferred(item)
	await get_tree().process_frame
	if item.ref.pickup.picked_up:
		return
	var random_angle: float = randf_range(0, TAU)
	var throw_dir: Vector2 = Vector2.RIGHT.rotated(random_angle)
	var random_speed: float = randf_range(50.0, 100)
	
	var drop_throw = {"direction": throw_dir, "speed": random_speed, "arc": 300}
	
	item.ref.pickup._get_thrown(drop_throw)
