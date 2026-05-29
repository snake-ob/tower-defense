extends Node
class_name Explosion

@export var attack: AttackData
var explode_timer: Timer
var explosion_time: float = 1.0
@onready var ref: Ref = $Ref

func _ready():
	explode_timer = Timer.new()
	explode_timer.one_shot = true
	explode_timer.timeout.connect(_on_explode)
	add_child(explode_timer)
	
	_setup_ref()
	_setup_nodes(self)
	explode_timer.start(explosion_time)
	
func _setup_ref():
	ref.set('actor', self)
	ref.set('attack', attack)
	
func _setup_nodes(p_node):
	for node in p_node.get_children():
		if node.has_method('_setup'):
			node._setup(ref)
		if node.get_child_count() > 0:
			_setup_nodes(node)
	
func _on_explode():
	queue_free()
