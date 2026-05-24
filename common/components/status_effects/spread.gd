extends Area2D
class_name Spread

@export var status: StatusEffect

func _ready() -> void:
	if not area_entered.is_connected(_area_entered):
		area_entered.connect(_area_entered)
	if not area_exited.is_connected(_area_exited):
		area_exited.connect(_area_exited)

func _area_entered(area: Hurtbox):
	pass

func _area_exited(area: Hurtbox):
	pass

func _set_collision_shape(p_shape):
	pass
