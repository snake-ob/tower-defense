extends Area2D
class_name Hurtbox

@export var iframe_length: float = 2

var ref: Ref
var actor: Node2D
signal got_hit(hit)

func _setup(p_ref):
	ref = p_ref
	actor = p_ref.actor

func take_hit(hit: Dictionary):
	got_hit.emit(hit)

func get_owner_actor():
	return ref.actor
	
func enable_iframes():
	set_deferred('monitorable', false)
	await get_tree().create_timer(iframe_length).timeout
	set_deferred('monitorable', true)
