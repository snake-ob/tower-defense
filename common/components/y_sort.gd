extends Node2D

var actor: Node2D

func _setup(p_ref: Ref):
	actor = p_ref.actor

func _physics_process(delta):
	if actor:
		actor.z_index = self.global_position.y
