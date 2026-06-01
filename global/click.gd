extends Node
class_name Click

signal clicked(actor)

var player_node: Node2D
var zone_radius: int = 200

var _object_clicked_this_frame: bool = false

func register_player(player: CharacterBody2D, radius: float) -> void:
	player_node = player
	zone_radius = radius

func report_click(target_actor: Node2D, click_position: Vector2) -> void:
	if not is_instance_valid(player_node):
		return
		
	var distance = player_node.global_position.distance_to(click_position)
	
	if distance <= zone_radius:
		_object_clicked_this_frame = true
		clicked.emit(target_actor)

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_evaluate_empty_space_click.call_deferred()

func _evaluate_empty_space_click() -> void:
	if _object_clicked_this_frame:
		_object_clicked_this_frame = false
		return
	clicked.emit(null)
