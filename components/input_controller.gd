extends Node

var ref: Ref = null
var input_axis: Vector2 = Vector2(0,0)


func _setup(p_ref):
	ref = p_ref

func _process(delta: float) -> void:
	var verti = Input.get_axis('ui_up', 'ui_down')
	var hori = Input.get_axis('ui_left', 'ui_right')
	input_axis = Vector2(hori, verti)
