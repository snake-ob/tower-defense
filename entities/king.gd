extends CharacterBody2D
class_name King

@onready var ref: Ref = $Ref
@export var move: MoveData


func _ready():
	_setup_ref()
	_setup_nodes(self)
	$StateMachine._set_state('idle')

func _setup_ref():
	ref.set('actor', self)
	ref.set('sprite', $AnimatedSprite2D)
	ref.set('physics', $PhysicsHandler)
	ref.set('pickup', $Pickup)
	ref.set('collision', $CollisionShape2D)
	ref.set('soft_collision', $SoftCollision)
	ref.set('collisions', [$SoftCollision/CollisionShape2D, $Pickup/CollisionShape2D])

func _physics_process(delta: float) -> void:
	move_and_slide()

func _setup_nodes(p_node):
	for node in p_node.get_children():
		if node.has_method('_setup'):
			node._setup(ref)
		if node.get_child_count() > 0:
			_setup_nodes(node)

func _clicked():
	pass
	
func stop_throw():
	ref.physics.stop_throw()
	
func disable_soft_collision():
	$SoftCollision.disable()
