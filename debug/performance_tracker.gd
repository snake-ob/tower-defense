extends Node

var enemy_count: int = 0

func register_enemy() -> void:
	enemy_count += 1

func unregister_enemy() -> void:
	enemy_count -= 1
