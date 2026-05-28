extends Area2D

signal clicked(caller)
var actor: Node2D

func _setup(p_ref):
	actor = p_ref.actor

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var click_position = get_global_mouse_position()
		GlobalClick.report_click(actor, click_position)
