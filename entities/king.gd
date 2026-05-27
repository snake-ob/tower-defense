extends CharacterBody2D
class_name King

@onready var ref: Ref = $Ref

func _ready():
	_setup_ref()
	_setup_nodes(self)
	$StateMachine._set_state('idle')


func _setup_ref():
	ref.set('actor', self)
	ref.set('sprite', $Sprite2D)
	ref.set('physics', $PhysicsHandler)
	ref.set('pickup', $Pickup)
	ref.set('collision', $CollisionShape2D)
	ref.set('soft_collision', $SoftCollision)

func _setup_nodes(p_node):
	for node in p_node.get_children():
		if node.has_method('_setup'):
			node._setup(ref)
		if node.get_child_count() > 0:
			_setup_nodes(node)
