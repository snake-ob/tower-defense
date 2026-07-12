extends CharacterBody2D

@onready var ref : Ref = $Ref

var speed: int = 5
var target: Vector2
var active_targets: Array[Node2D] = []
var direction: Vector2

@export var attack: AttackData
@export var move: MoveData
var status_upgrades: Array = []

@export var turn_speed: float = 5.0

func _ready() -> void:
	ref.set('actor', self)
	ref.set('data', $Data)
	ref.set('health', $Health)
	ref.set('attack', attack.duplicate())
	ref.set('move', move.duplicate())
	ref.set('hitbox', $Hitbox)
	ref.set('hurtbox', $Hurtbox)
	ref.set('status_upgrades', $StatusUpgrades)
	_setup_nodes(self)
	$Health.health_depleted.connect(_on_health_depleted)
	$Hurtbox.got_hit.connect(_on_got_hit)
	face_target()
	init_status_upgrades()

func _physics_process(delta: float) -> void:
	move_in_direction(delta)
	move_and_slide()

func _set_collisions(p_collision):
	$Hurtbox.set_collision_layer_value(p_collision.layer, true)
	$Hitbox.set_collision_mask_value(p_collision.mask, true)

func face_target():
	direction = (target - global_position).normalized()
	rotation = direction.angle() - deg_to_rad(-90)
	var sprite_anim = get_node_or_null('AnimatedSprite2D')
	if sprite_anim:
		sprite_anim.scale.x = sign(direction.x)

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
	
func _set_status_upgrades(p_status_upgrades_node: Node):
	if p_status_upgrades_node == null:
		return
	var p_status_upgrades = p_status_upgrades_node.get_children()
	if p_status_upgrades == []:
		return
	for status_upgrade in p_status_upgrades:
		status_upgrades.append(status_upgrade)

func init_status_upgrades():
	for upgrade in status_upgrades:
		ref.status_upgrades.add_child(upgrade.duplicate())
