extends Node
class_name Health

@export var max_health: int = 1
@onready var current_health: int = max_health

signal health_depleted()

func _take_damage(damage):
	current_health -= damage
	if current_health <= 0:
		health_depleted.emit()
