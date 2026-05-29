extends Area2D
class_name Hitbox

var ref: Ref
var status_effects: Array = []

func _setup(p_ref):
	ref = p_ref
	
func _ready():
	if not area_entered.is_connected(_on_area_entered):
		area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	var damage = ref.attack.damage
	var knockback = ref.attack.knockback
	var position = ref.actor.global_position
	if ref.has('status_upgrades'):
		for status_upgrade in ref.status_upgrades.get_children():
			var status = status_upgrade._get_status()
			status_effects.append(status)
	
	var hit = {'damage': damage, 'knockback': knockback, 'position': position, 'status_effects': status_effects}
	area.take_hit(hit)
	
func _get_collision_shape():
	return $CollisionShape2D.get_shape().duplicate()	
