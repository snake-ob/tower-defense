extends CharacterBody2D
class_name Coin

@onready var ref: Ref = $Ref
@export var move: MoveData
var collected: bool = false

func _ready():
	_setup_ref()
	_setup_nodes(self)
	
func _setup_ref():
	ref.set('actor', self)
	ref.set('physics', $PhysicsHandler)
	ref.set('collisions', [$CollisionShape2D])
	ref.set('sprite', $Sprite2D)
	ref.set('pickup', $Pickup)
	
func _setup_nodes(p_node):
	for node in p_node.get_children():
		if node.has_method('_setup'):
			node._setup(ref)
		if node.get_child_count() > 0:
			_setup_nodes(node)

func _physics_process(delta):
	if collected: return
	move_and_slide()
	var player = $CollectZone.get_primary_target()
	if player != null:
		velocity = Vector2.ZERO
		_collect()
		return
	var target = $DetectZone.get_primary_target()
	if not target:
		ref.physics._process_friction(delta)
		return
	
	var distance = global_position.distance_to(target.global_position)
	var direction = global_position.direction_to(target.global_position)
	var speed = move.speed/distance
	velocity = direction * speed

func _collect():
	collected = true
	var sprite: AnimatedSprite2D = $Sprite2D
	SignalBus.coin_collected.emit()
	sprite.animation = "collect"
	sprite.animation_finished.connect(_on_sprite_finished)
	sprite.play()
	
func _on_sprite_finished():
	queue_free()
