extends Node

@export var enemy_scene: Enemy

var level: Node2D
var enemies: Node
var spawn_timer: Timer
var spawn_time: float = 3.5

func _setup(p_ref):
	level = p_ref.level
	enemies = p_ref.enemies

func _ready():
	spawn_timer = Timer.new()
	spawn_timer.timeout.connect(_on_spawn)
	spawn_timer.start(spawn_time)

func get_random_position() -> Vector2:
	$SpawnPos.progress_ratio = randf()
	return $SpawnPos.global_position

func _on_spawn():
	var enemy = enemy_scene.instantiate()
	enemy.global_position = get_random_position()
	enemies.add_child(enemy)
