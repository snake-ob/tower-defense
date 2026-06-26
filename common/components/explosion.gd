extends Node
class_name Explosion

@export var attack: AttackData
var explode_timer: Timer
var explosion_time: float = 1.0
@onready var ref: Ref = $Ref

func _ready():
	_setup_ref()
	_setup_nodes(self)
	$Sprite2D.play('explode')
	$Sprite2D.animation_finished.connect(_on_explode)

func _setup_ref():
	ref.set('actor', self)
	ref.set('attack', attack)
	ref.set('sprite', $Sprite2D)
	
func _setup_nodes(p_node):
	for node in p_node.get_children():
		if node.has_method('_setup'):
			node._setup(ref)
		if node.get_child_count() > 0:
			_setup_nodes(node)

func _on_explode():
	queue_free()
	
