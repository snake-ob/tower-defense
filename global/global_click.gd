# GlobalClick.gd
extends Node

signal clicked(actor)
signal rmb_click()

var player_node: Node2D = null
var zone_radius: float = 200.0

const PICKUP_COLLISION_LAYER: int = 14

func register_player(player: CharacterBody2D, radius: float) -> void:
	player_node = player
	zone_radius = radius

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_process_click()
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		rmb_click.emit()

func _process_click() -> void:
	if not is_instance_valid(player_node):
		return

	var mouse_pos = player_node.get_global_mouse_position()
	var distance = player_node.global_position.distance_to(mouse_pos)

	if distance > zone_radius:
		clicked.emit(null)
		return

	var space_state = player_node.get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	
	query.position = mouse_pos
	query.collide_with_areas = true
	query.collide_with_bodies = false
	
	query.collision_mask = 1 << (PICKUP_COLLISION_LAYER - 1)

	var results = space_state.intersect_point(query)

	if not results.is_empty():
		for result in results:
			var hit_collider = result.collider
			
			if "actor" in hit_collider:
				clicked.emit(hit_collider.actor)
				return
				
	clicked.emit(null)
