extends CharacterBody2D
class_name Bomb

@onready var ref: Ref = $Ref
@export var move: MoveData
@export var ExplodeScene: PackedScene

func _ready():
	_setup_ref()
	_setup_nodes(self)
	$StateMachine._set_state('idle')

func _physics_process(delta):
	move_and_slide()

func _setup_ref():
	ref.set('actor', self)
	ref.set('physics', $PhysicsHandler)
	ref.set('pickup', $Pickup)
	ref.set('sprite', $Sprite2D)
	ref.set('SM', $StateMachine)
	ref.set('detect_zone', $DetectZone)

func _setup_nodes(p_node):
	for node in p_node.get_children():
		if node.has_method('_setup'):
			node._setup(ref)
		if node.get_child_count() > 0:
			_setup_nodes(node)
	
func explode():
	_spawn_explosion()
	queue_free()

func _spawn_explosion():
	var explosion = ExplodeScene.instantiate()
	explosion.global_position = ref.actor.global_position
	SignalBus.spawn_bullet.emit(explosion)
