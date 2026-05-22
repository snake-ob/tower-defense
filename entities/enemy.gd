extends CharacterBody2D
class_name Enemy

@export_category("Enemy Data")
@export var move: MoveData
@export var attack: AttackData

@onready var ref = $Ref

func _physics_process(delta: float) -> void :
	move_and_slide()

func _ready() -> void:
	_setup_ref()
	_setup_nodes(self)
	$StateMachine._set_state('chase')
	$Health.health_depleted.connect(_on_health_depleted)
	$Hurtbox.got_hit.connect(_on_got_hit)

func _setup_ref():
	if move: ref.set('move', move.duplicate())
	if attack: ref.set('attack', attack.duplicate())
	ref.set('body', $Body)
	ref.set('data', $Data)
	ref.set('health', $Health)
	ref.set('hurtbox', $Hurtbox)
	ref.set('active_targets', $DetectZone.active_targets)
	ref.set('actor', self)
	
func _setup_nodes(p_node):
	for child in p_node.get_children():
		if child.has_method('_setup'):
			
			child._setup(ref)
		if p_node.get_child_count() > 0:
			_setup_nodes(child)
			
func _on_health_depleted():
	queue_free()

func _on_got_hit(hit):
	ref.health.current_health -= hit.damage
	var knockback_direction = global_position - hit.position
	
	velocity += knockback_direction * hit.knockback
	
