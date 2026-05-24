extends Node
class_name Spawners

func _setup(p_ref):
	setup_children(p_ref)

func setup_children(p_ref):
	for child in get_children():
		if child.has_method('_setup'):
			child._setup(p_ref)
