extends CharacterBody2D
class_name Baggie

@onready var ref: Ref = $Ref
@export var move: MoveData
@export var ExplodeScene: PackedScene
@export var num_caltropes: int = 15

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
	ref.set('soft_collision', $SoftCollision)

func _setup_nodes(p_node):
	for node in p_node.get_children():
		if node.has_method('_setup'):
			node._setup(ref)
		if node.get_child_count() > 0:
			_setup_nodes(node)
	
func explode():
	for i in range(num_caltropes):
		_spawn_explosion()
	queue_free()

func _spawn_explosion():
	var caltrope = ExplodeScene.instantiate()
	caltrope.global_position = ref.actor.global_position
	
	var random_angle: float = randf_range(0, TAU)
	var move_direction: Vector2 = Vector2.RIGHT.rotated(random_angle)
	var random_speed: float = randf_range(100.0, 150)

	caltrope.velocity = move_direction * random_speed
	SignalBus.spawn_bullet.emit(caltrope)
