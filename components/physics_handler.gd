extends Node

var actor: Node2D = null
var ref: Ref = null

func _setup(p_ref):
	ref = p_ref
	actor = ref.actor

func _physics_process(delta: float) -> void:
	if ref.input_controller:
		var axis = ref.input_controller.input_axis
		actor.velocity = axis * actor.move.speed
