extends CharacterBody2D
class_name Enemy

@export_category("Enemy Data")
@export var move: MoveData
@export var attack: AttackData
@export var collision: CollisionData
@export var coins_held: int = 100

var coin_path: String = "res://entities/CoinEmitter.tscn"

@onready var ref = $Ref
var target: Vector2
var centre_pos: Vector2

var slowed_down: bool = false

func _physics_process(delta: float) -> void :
	move_and_slide()

func _ready() -> void:
	_setup_ref()
	_setup_nodes(self)
	if ref.sprite.material:
		ref.sprite.material = ref.sprite.material.duplicate()
	$StateMachine._set_state('chase')
	$Health.health_depleted.connect(_on_health_depleted)
	$Hurtbox.got_hit.connect(_on_got_hit)
	
	PerformanceTracker.register_enemy()

func _setup_ref():
	if move: ref.set('move', move.duplicate())
	if attack: ref.set('attack', attack.duplicate())
	var bullet_spawner = get_node_or_null("BulletSpawner")
	ref.set('body', $Body)
	ref.set('data', $Data)
	ref.set('health', $Health)
	ref.set('hitbox', $Hitbox)
	ref.set('hurtbox', $Hurtbox)
	ref.set('active_targets', $DetectZone.active_targets)
	ref.set('detect_zone', $DetectZone)
	ref.set('bullet_spawner', bullet_spawner)
	ref.set('status_effects', $StatusEffects)
	ref.set('physics', $PhysicsHandler)
	ref.set('pickup', $Pickup)
	ref.set('sprite', $Body/AnimatedSprite2D)
	ref.set('target', Vector2.ZERO)
	ref.set('grab', $Grab)
	ref.set('soft_collision', $SoftCollision)
	ref.set('collisions', [$CollisionShape2D, $SoftCollision/CollisionShape2D])
	ref.set('collision', $CollisionShape2D)
	ref.set('animanager', $Body/AniManager)
	ref.set('actor', self)
	
func _setup_nodes(p_node):
	for child in p_node.get_children():
		if child.has_method('_setup'):
			
			child._setup(ref)
		if p_node.get_child_count() > 0:
			_setup_nodes(child)
			
func _cleanup_nodes(p_node):
	for child in p_node.get_children():
		if not is_instance_valid(child): pass
		if child.has_method('_cleanup'):
			child._cleanup()
		if p_node.get_child_count() > 0:
			_cleanup_nodes(child)
			
func _on_health_depleted():
	PerformanceTracker.unregister_enemy()
	_cleanup_nodes(self)
	_die()
	

func _on_got_hit(hit):
	ref.sprite.trigger_flicker()
	var knockback_direction = global_position - hit.position
	velocity += knockback_direction * hit.knockback
	if hit.status_effects != []:
		apply_status_effects(hit.status_effects)

	ref.health._take_damage(hit.damage)

	
		
func apply_status_effects(p_effects):
	for p_effect in p_effects:
		var has_effect = false
		for active_effect in ref.status_effects.get_children():
			if active_effect.scene_file_path == p_effect.resource_path:
				has_effect = true
				active_effect.renew()
		if not has_effect:		
			var effect_node = p_effect.instantiate()
			effect_node._setup(ref)
			ref.status_effects.add_child.call_deferred(effect_node)
			
func update_target(p_target):
	ref.set('target', p_target)

func catch_exit_pos(p_pos):
	target = p_pos
	ref.target = p_pos
	
func _die():
	emit_drop()
	$StateMachine._set_state('die')
	
func emit_drop():
	var coin_scene = load(coin_path)
	var coin_emitter: CoinEmitter = coin_scene.instantiate()
	var parent = get_parent()
	coin_emitter.global_position = global_position
	SignalBus.add_object_to_scene.emit(coin_emitter)
	coin_emitter.stagger_drop(coins_held)

func retreat():
	$StateMachine._set_state('retreat')
	
func reset():
	$StateMachine._set_state('reset')
	
