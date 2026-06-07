extends Node2D
class_name Tower

@onready var ref: Ref = $Ref
@export_category("Bullet Data")
@export var move: MoveData
@export var attack: AttackData
@export var collision: CollisionData

func _ready() -> void:
	_setup_ref()
	_setup_nodes(self)
	$StateMachine._set_state('active')

func _setup_nodes(p_node):
	for child in p_node.get_children():
		if child.has_method('_setup'):
			child._setup(ref)
		if p_node.get_child_count() > 0:
			_setup_nodes(child)

func _physics_process(delta):
	global_position = global_position.round()

func _setup_ref():
	ref.set('actor', self)
	ref.set('bullet_spawner', $BulletSpawner)
	ref.set('detect_zone', $DetectZone)
	ref.set('pickup', $Pickup)
	ref.set('collision', collision)
	ref.set('collisions', [])
	ref.set('physics', $PhysicsHandler)
	ref.set('status_upgrades', $StatusUpgrades)
	ref.set('sprite', $Body/Sprite2D)
	ref.set('body', $Body)
	if move: ref.set('move', move.duplicate())
	if attack: ref.set('attack', attack.duplicate())
