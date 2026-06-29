extends Node
class_name Target

var target: Vector2
var actor: Node2D
var ref: Ref

func _setup(p_ref):
	ref = p_ref
	actor = p_ref.actor

func get_closest_target(enemy_dir):
	var actor_pos = ref.actor.global_position
	var closest_enemy = null
	var closest_distance = null
	for enemy in enemy_dir:
		if not _path_clear(enemy): continue

		if closest_enemy == null:
			closest_enemy = enemy
			closest_distance = actor_pos.distance_squared_to(enemy.global_position)
			continue
		
		var enemy_pos = enemy.global_position
		var distance_from_child = actor_pos.distance_squared_to(enemy_pos)
		if distance_from_child < closest_distance:
			closest_enemy = enemy
			closest_distance = distance_from_child
	
	if closest_enemy:
		return closest_enemy.global_position
	else:
		return null
		
func _path_clear(p_pos) -> bool:
	var ray:RayCast2D = $RayCast2D
	ray.global_position = actor.global_position
	ray.target_position = ray.to_local(p_pos.global_position)
	
	ray.force_raycast_update()
	return !ray.is_colliding()
