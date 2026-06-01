extends CharacterBody2D

@onready var ref: Ref = $Ref
@export var move: MoveData

func _ready():
	_setup_ref()
	_setup_nodes(self)
	$StateMachine._set_state('idle')
	
func _physics_process(delta: float) -> void:
	move_and_slide()

func _setup_nodes(p_node):
	for child in p_node.get_children():
		if child.has_method('_setup'):
			child._setup(ref)
		if child.get_child_count() > 0:
			_setup_nodes(child)

func _setup_ref():
	ref.set('actor', self)
	ref.set('physics', $PhysicsHandler)
	ref.set('detect_zone', $DetectZone)
	ref.set('soft_collision', $SoftCollision)
