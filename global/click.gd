extends Node
class_name Click

signal clicked(actor)

var player_node: Node2D
var zone_radius: int = 200


func register_player(player: CharacterBody2D, radius: float) -> void:
	player_node = player
	zone_radius = radius

func report_click(target_actor: Node2D, click_position: Vector2) -> void:
	if not is_instance_valid(player_node):
		return
		
	var distance = player_node.global_position.distance_to(click_position)
	
	if distance <= zone_radius:
		clicked.emit(target_actor)
