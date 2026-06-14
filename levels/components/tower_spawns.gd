extends Path2D

func get_random_position() -> Vector2:
	$SpawnPos.progress_ratio = randf()
	return $SpawnPos.global_position

func get_closest_position(target_node: Node2D) -> Vector2:
	var local_node_pos: Vector2 = to_local(target_node.global_position)
	var local_closest_point: Vector2 = curve.get_closest_point(local_node_pos)
	
	return to_global(local_closest_point)
