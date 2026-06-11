extends Node

var current_scene: Node

func _next_scene(p_scene: PackedScene):
	var new_scene = p_scene.instantiate()
	add_child(new_scene)
	if current_scene != null:
		await get_tree().process_frame
		current_scene.queue_free()
	current_scene = new_scene
