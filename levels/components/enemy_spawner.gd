extends Node
class_name EnemySpawner

@export var enemy_scene: PackedScene
@export var spawning: bool = true
@export var point_cost: int = 1

var level: Node2D
var enemies: Node
var spawn_timer: Timer
@export var spawn_time: float = 1
var spawn_path: Node2D
var centre: Vector2

func _setup(p_ref):
	level = p_ref.level
	enemies = p_ref.enemies
	spawn_path = p_ref.spawn_path
	centre = p_ref.centre
	

func _setup_lvl(p_ref):
	level = p_ref.level
	enemies = p_ref.enemies
	spawn_path = p_ref.spawn_path
	centre = p_ref.centre

func spawn_enemy():
	if !spawning: return
	var enemy = enemy_scene.instantiate()
	enemy.global_position = spawn_path.get_random_position()
	enemy.target = centre
	enemy.centre_pos = centre
	enemies.add_child(enemy)
