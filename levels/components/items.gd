extends Node2D


func _ready():
	SignalBus.spawned.connect(_on_item_spawn)

func _on_item_spawn(item):
	add_child.call_deferred(item)
	await get_tree().process_frame	
	var random_angle: float = randf_range(0, TAU)
	var throw_dir: Vector2 = Vector2.RIGHT.rotated(random_angle)
	var random_speed: float = randf_range(50.0, 100)
	
	var drop_throw = {"direction": throw_dir, "speed": random_speed, "arc": 300}

	item.ref.pickup._get_thrown(drop_throw)
