extends CharacterBody2D
class_name Tower

@onready var ref: Ref = $Ref
@export_category("Bullet Data")
@export var move: MoveData
@export var attack: AttackData
@export var collision: CollisionData

var id: int

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
	move_and_slide()

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
	ref.set('slots', $Body/Slots)
	ref.set('body', $Body)
	ref.set('upgrades', $StatusUpgrades)
	ref.set('soft_collision', $SoftCollision)
	ref.set('physics', $PhysicsHandler)
	ref.set('target_node', $Target)
	if move: ref.set('move', move.duplicate())
	if attack: ref.set('attack', attack.duplicate())

func add_rune(rune_node):
	$Body/Slots.slot_rune(rune_node)
