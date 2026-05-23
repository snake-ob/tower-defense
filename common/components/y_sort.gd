extends Node2D

var actor: Node2D
@onready var screen_height: int = get_window().size.y

func _setup(p_ref: Ref):
	actor = p_ref.actor

func _physics_process(delta):
	var clamped_y = clamp(self.global_position.y, 0.0, screen_height)
	actor.z_index = int(clamped_y)
