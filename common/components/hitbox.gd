extends Area2D
class_name Hitbox

var ref: Ref

func _setup(p_ref):
	ref = p_ref

func _on_area_entered(area: Area2D) -> void:		
	var damage = ref.attack.damage
	var knockback = ref.attack.knockback
	var position = ref.actor.global_position
	var status = ""
	
	var hit = {'damage': damage, 'knockback': knockback, 'position': position, 'status': status}
	area.take_hit(hit)
