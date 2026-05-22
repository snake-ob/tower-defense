extends CharacterBody2D

@onready var ref: Ref = $Ref
var speed: int = 100
var target: Vector2

func _ready() -> void:
	pass
	
func _setup(p_ref):
	# Passed from tower
	ref.actor = self
	ref.enemies = p_ref.enemies
	_setup_nodes(self)
	target = $Target.target	

func _physics_process(delta: float) -> void:
	move_to_target()
	move_and_slide()

func move_to_target():
	if not target:
		return
		
	var current_pos = self.global_position
	var direction = target - current_pos
	
	self.velocity = direction * speed
	
func _setup_nodes(p_node):
	for child in p_node.get_children():
		if child.has_method('_setup'):
			child._setup(ref)
		if p_node.get_child_count() > 0:
			_setup_nodes(child)
