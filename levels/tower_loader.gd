extends Node2D

var towers: Node
var tower_spawns: Node

var tower_path = 'res://entities/tower/Tower.tscn'

func _setup_lvl(p_ref):
	towers = p_ref.towers
	tower_spawns = p_ref.tower_spawns
	for tower in GameData.towers:
		var spawn_pos = tower_spawns.get_random_position()
		var tower_scene = load(tower_path)
		var new_tower = tower_scene.instantiate()
		new_tower.id = tower.id
		_copy_runes(tower, new_tower)
		new_tower.global_position = spawn_pos
		towers.add_child(new_tower)

func _copy_runes(saved_tower, game_tower):
	for rune_path in saved_tower.runes:
		var rune_scene = load(rune_path)
		var new_rune = rune_scene.instantiate()
		
		game_tower.add_rune(new_rune)
