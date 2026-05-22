extends Node
class_name EnemySpawner

var level: Node2D
var spawn_timer: Timer
var spawn_time: float = 3.5

func _setup(p_ref):
	level = p_ref.level

func _ready() -> void:
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
