extends CharacterBody2D

@onready var ref : Ref = $Ref

var speed: int = 5
var target: Vector2
var active_targets: Array[Node2D] = []
var direction: Vector2

var attack: AttackData
var move: MoveData

@export var turn_speed: float = 5.0

func _ready() -> void:
	ref.set('actor', self)
	ref.set('data', $Data)
	ref.set('health', $Health)
	ref.set('attack', attack.duplicate())
	ref.set('move', move.duplicate())
	_setup_nodes(self)
	$Health.health_depleted.connect(_on_health_depleted)
	$Hurtbox.got_hit.connect(_on_got_hit)
	face_target()

func _physics_process(delta: float) -> void:
	move_in_direction(delta)
	move_and_slide()
	
func face_target():
	if active_targets == []:
		return
		
	target = $Target.get_closest_target(active_targets)
	direction = (target - global_position).normalized()
	rotation = direction.angle() - deg_to_rad(-90)

func move_to_target(delta):
	var angle = direction.angle() - deg_to_rad(-90)
	
	rotation = lerp_angle(rotation, angle, turn_speed * delta)
	velocity = direction * speed * 100

func move_in_direction(delta):
	velocity = direction * speed * 100
	
func _setup_nodes(p_node):
	for child in p_node.get_children():
		if child.has_method('_setup'):
			child._setup(ref)
		if p_node.get_child_count() > 0:
			_setup_nodes(child)

func _on_health_depleted():
	self.queue_free()

func _on_got_hit(hit: Dictionary):
	#Hit {damage, knockback, position, status}
	ref.health._take_damage(1)
	
func _on_screen_exit():
	queue_free()
