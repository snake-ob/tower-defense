extends CharacterBody2D
class_name Enemy

@export var move: EnemyData
@onready var ref: Ref = $Ref

func physics_process(delta: float) -> void:
	pass

func _ready() -> void:
	_setup_ref()
	_setup_nodes(self)
	$StateMachine._set_state('chase')

func _setup_ref():
	ref.body = $Body
	ref.actor = self
	
func _setup_nodes(p_node):
	for child in p_node.get_children():
		if child.has_method('_setup'):
			child._setup(ref)
		if p_node.get_child_count() > 0:
			_setup_nodes(child)
