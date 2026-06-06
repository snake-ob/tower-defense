extends Node
class_name Block

@onready var ref: Ref = $Ref

func _ready():
	_setup_ref()
	_setup_nodes(self)
	
func _setup_ref():
	ref.set('actor', self)

func _setup_nodes(p_node):
	for child in p_node.get_children():
		if child.has_method('_setup'):
			child._setup(ref)
		if child.get_child_count() > 0:
			_setup_nodes(child)
