extends Node2D

@onready var ref: Ref = $Ref

func _ready():
	_setup_ref()
	_setup_nodes(self)
	$Camera2D.offset.y = 10

func _setup_ref():
	ref.set('top_left', $TopLeft.global_position)
	ref.set('bottom_right', $BottomRight.global_position)

func _setup_nodes(p_node):
	for child in p_node.get_children():
		if child.has_method('_setup'):
			child._setup(ref)
		if child.get_child_count() > 0:
			_setup_nodes(child)
