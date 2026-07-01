extends Node
class_name PhysicsHandler

signal throw_finished

var actor: Node2D
var sprite: Node

@export var gravity: float = 1200.0
@export var bounce_elasticity: float = 0.5
@export var min_bounce_velocity: float = 10
@export var wall_bounce: float = 0.7

var horizontal_velocity: Vector2 = Vector2.ZERO
var height: float = 0.0
var height_velocity: float = 0.0
var is_active: bool = false

var base_sprite_y: float = 0.0

func _setup(p_ref):
	actor = p_ref.actor
	if p_ref.has('body'):
		sprite = p_ref.body
	elif p_ref.has('sprite'):
		sprite = p_ref.sprite
		
	base_sprite_y = sprite.position.y

func _physics_process(delta: float) -> void:
	if not is_active:
		return
		
	var collision = actor.move_and_collide(horizontal_velocity * delta)
	if collision:
		horizontal_velocity = horizontal_velocity.bounce(collision.get_normal()) * wall_bounce

	height_velocity -= gravity * delta
	height += height_velocity * delta
	
	if height <= 0.0:
		height = 0.0
		height_velocity = -height_velocity * bounce_elasticity
		horizontal_velocity *= 0.6 
		
		if height_velocity < min_bounce_velocity:
			is_active = false
			horizontal_velocity = Vector2.ZERO
			sprite.position.y = base_sprite_y
			throw_finished.emit()
	sprite.position.y = base_sprite_y - height

func _process_friction(delta):
	actor.velocity = actor.velocity.move_toward(Vector2.ZERO, actor.move.friction * delta)

func start_25d_throw(direction: Vector2, speed: float, arc_strength: float):
	if actor is CharacterBody2D:
		actor.velocity = Vector2.ZERO
	horizontal_velocity = direction * speed
	height = 0.0
	height_velocity = arc_strength
	is_active = true
	
func stop_throw() -> void:
	sprite.position.y = base_sprite_y
	is_active = false
	horizontal_velocity = Vector2.ZERO
	height = 0.0
	height_velocity = 0.0
