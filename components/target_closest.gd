extends Node
class_name Target

var target: Vector2
var actor: Node2D
var ref: Ref

func _setup(p_ref):
	ref = p_ref
	target = get_closest_target(ref.enemies.dir)

func get_closest_target(enemy_dir):
	print(enemy_dir)
	var actor_pos = ref.actor.global_position
	var closest_enemy = null
	var closest_distance = null
	for enemy in enemy_dir:
		if closest_enemy == null:
			closest_enemy = enemy
			continue

		var enemy_pos = enemy.global_position
		var distance_from_child = actor_pos.distance_squared_to(enemy_pos)
		if distance_from_child < closest_distance:
			closest_enemy = enemy
			closest_distance = distance_from_child
	
	if closest_enemy:
		return closest_enemy.global_position
	else:
		return Vector2(0,0)
