extends Area2D
class_name Hurtbox

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
