extends Node
class_name Health

@export var max_health: int = 1
@onready var current_health: int = max_health
var depleted: bool = false
var actor: Node2D

signal health_depleted()

func _setup(p_ref):
	actor = p_ref.actor

func _take_damage(damage):
	if depleted: return
	current_health -= damage
	if current_health <= 0:
		depleted = true
		health_depleted.emit()
	if actor is Player:
		SignalBus.player_hit.emit(current_health)
