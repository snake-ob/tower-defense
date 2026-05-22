extends Node

func get_random_position() -> Vector2:
	$SpawnPos.progress_ratio = randf()
	return $SpawnPos.global_position
