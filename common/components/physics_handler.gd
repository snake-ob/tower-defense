extends Node

var actor: Node2D

func _setup(p_ref):
	actor = p_ref.actor

func _physics_process(delta: float) -> void:
	pass

func _process_friction(delta):
	actor.velocity = actor.velocity.move_toward(Vector2.ZERO, actor.move.friction * delta)
