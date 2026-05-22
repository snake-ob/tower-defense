extends Node

@export var enemy_scene: PackedScene

var level: Node2D
var enemies: Node
var spawn_timer: Timer
var spawn_time: float = 3.
var spawn_path: Node2D

func _setup(p_ref):
	level = p_ref.level
	enemies = p_ref.enemies
	spawn_path = p_ref.spawn_path

func _ready():
	spawn_timer = Timer.new()
	spawn_timer.timeout.connect(_on_spawn)
	add_child(spawn_timer)
	spawn_timer.start(spawn_time)

func _on_spawn():
	var enemy = enemy_scene.instantiate()
	enemy.global_position = spawn_path.get_random_position()
	enemies.add_child(enemy)
