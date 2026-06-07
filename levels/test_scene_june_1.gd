extends Node2D

@onready var ref: Ref = $Ref

func _ready() -> void:
	SignalBus.spawn_bullet.connect(_spawn_bullet)
	SignalBus.request_closest_exit.connect(_return_closest_exit)
	_setup_ref()
	_setup_nodes(self)
	$EnemySpawner.centre = $Centre.global_position
	
func _setup_ref():
	ref.set('level', self)
	ref.set('enemies', $Enemies)
	ref.set('spawn_path', $SpawnPath)
	ref.set('spawners', $Spawners)
	ref.set('player', $Player)
	ref.set('centre', $Centre.global_position)
	
func _setup_nodes(p_node):
	for child in p_node.get_children():
		if child.has_method('_setup'):
			child._setup(ref)

func _spawn_bullet(p_bullet):
	$Projectiles.add_child(p_bullet)

func _return_closest_exit(p_node):
	var closest_pos = $SpawnPath.get_closest_position(p_node)
	p_node.catch_exit_pos(closest_pos)
