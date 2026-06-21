extends CharacterBody2D
class_name Player

@onready var ref: Ref = $Ref
@export_category("Player Data")
@export var move: MoveData
@export var build_radius: int = 200

var slowed_down: bool = false

var holding: bool = false

func _physics_process(delta):
	if move: ref.move = move.duplicate()
	move_and_slide()
	global_position = global_position.round()
	
func _ready():
	_setup_ref()
	_setup_nodes(self)
	GlobalClick.register_player(self, build_radius)
	$StateMachine._set_state('idle')
	$Hurtbox.got_hit.connect(_take_hit)
	$Health.health_depleted.connect(_health_depleted)

func _process(delta):
	ref.set('target', $Grab/DropPos.global_position)

	
func _setup_ref():
	ref.set('input_controller', $InputController)
	ref.set('visuals', $Visuals)
	ref.set('sprite', $Visuals/AnimatedSprite2D)
	ref.set('physics', $PhysicsHandler)
	ref.set('grab', $Grab)
	ref.set('health', $Health)
	ref.set('actor', self)
	ref.set('target', $Grab/DropPos.global_position)
	ref.set('animanager', $Visuals/AniManager)
	ref.set('collision', $CollisionShape2D)
	
func _setup_nodes(p_node):
	for child in p_node.get_children():
		if child.has_method('_setup'):
			child._setup(ref)
		if p_node.get_child_count() > 0:
			_setup_nodes(child)
			
func _take_hit(hit):
	var knockback_direction = global_position - hit.position
	velocity += knockback_direction * hit.knockback
	$Health._take_damage(hit.damage)
	ref.sprite.trigger_flicker()
	$Hurtbox.enable_iframes()
	# Health damage
	# Disable hurtbox (maybe hurtbox has iframes function that resets on timer)
	# Sprite flashes white	
	
func spawn_in_hand(p_item):
	if ref.grab.grabbed_pickup != null:
		ref.grab._put_down()
	var p_pickup = p_item.ref.pickup
	ref.grab._pickup_object(p_pickup)
	
func _health_depleted():
	_player_die()
	
func _player_die():
	$StateMachine._set_state('die')
