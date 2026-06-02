extends CharacterBody2D
class_name Gem

@onready var ref: Ref = $Ref
@export var RuneScene: PackedScene

func _ready():
	_setup_ref()
	_setup_nodes(self)

func _physics_process(delta: float) -> void:
	move_and_slide()

func _setup_ref():
	ref.set('actor', self)
	ref.set('soft_collision', $SoftCollision)
	ref.set('physics', $PhysicsHandler)
	ref.set('pickup', $Pickup)
	ref.set('sprite', $Sprite2D)
	
func _setup_nodes(p_node):
	for child in p_node.get_children():
		if child.has_method('_setup'):
			child._setup(ref)
		if child.get_child_count() > 0:
			_setup_nodes(child)
			
func transfer_gem(p_slot):
	var new_rune = RuneScene.instantiate()
	p_slot.slot_rune(new_rune)
	queue_free()
	
func disable_slotting():
	$CollisionShape2D.disabled = true
	if not is_inside_tree():
		await tree_entered
	var slot_timer = Timer.new()
	add_child(slot_timer)
	slot_timer.one_shot = true
	slot_timer.timeout.connect(func(): $CollisionShape2D.disabled = false)
	slot_timer.start(3)
	
