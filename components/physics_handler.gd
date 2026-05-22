extends Node

var actor: Node2D = null
var ref: Ref = null

func _setup(p_ref):
	ref = p_ref
	actor = ref.actor

func _physics_process(delta: float) -> void:
	if ref.has('input_controller'):
		var axis = ref.input_controller.input_axis
		actor.velocity = axis * actor.move.speed
	_process_friction(delta)

func _process_friction(delta):
	actor.velocity = actor.velocity.move_toward(Vector2.ZERO, actor.move.friction * delta)
