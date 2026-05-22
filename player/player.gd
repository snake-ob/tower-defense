extends CharacterBody2D
class_name Player

@onready var ref: Ref = $Ref
@export_category("Player Data")
@export var move: MoveData

func _physics_process(delta):
	if move: ref.move = move.duplicate()
	move_and_slide()
	
func _ready():
	_setup_ref()
	_setup_nodes(self)
	$StateMachine._set_state('idle')
	
func _setup_ref():
	ref.set('input_controller', $InputController)
	ref.set('visuals', $Visuals)
	ref.set('physics', $PhysicsHandler)
	ref.set('grab', $Grab)
	ref.set('actor', self)
	
func _setup_nodes(p_node):
	for child in p_node.get_children():
		if child.has_method('_setup'):
			child._setup(ref)
		if p_node.get_child_count() > 0:
			_setup_nodes(child)
