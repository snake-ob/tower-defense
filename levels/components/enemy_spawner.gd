extends Node
class_name EnemySpawner

# This node is initialized from the LevelManager into the Spawners node
# LevelManager will pass spawner data to (scene, spawning, and point cost)
# THe WaveManager will call spawn_enemy on this node. This spawner does not care about timing

@export var enemy_scene: PackedScene
@export var spawning: bool = true
@export var point_cost: int = 1

var enemies: Node
var spawn_path: Node2D
var centre: Vector2

func _setup(p_ref):
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
	
func setup_spawner(p_data):
	enemy_scene = p_data.enemy_scene
	spawning = p_data.spawning
	point_cost = p_data.point_cost
	enemies = p_data.enemies
	spawn_path = p_data.spawn_path
	centre = p_data.centre
