extends Area2D
class_name Hurtbox

var ref: Ref
signal got_hit(hit)

func _setup(p_ref):
	ref = p_ref

func take_hit(hit: Dictionary):
	got_hit.emit(hit)
