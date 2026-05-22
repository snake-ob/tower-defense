extends Node
class_name PhysicsProcess

var actor: Node2D
var friction: float

func _setup(p_ref):
	actor = p_ref.actor
	friction = p_ref.actor.friction

func _physics_process(delta):
	_apply_friction(delta)
	
func _apply_friction(delta):
	actor.velocity = actor.velocity.move_toward(Vector2.ZERO, friction * delta)
