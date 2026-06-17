#pickup.gd
extends Area2D
class_name Pickup

var picked_up: bool = false
var thrown: bool = true
var throw_dir: Vector2 = Vector2(0,0)
var grab_pos: Node2D
var drop_pos: Node2D
var actor: Node2D
var physics: Node
var collisions: Array

func _physics_process(delta: float) -> void:
	if picked_up:
		if is_instance_valid(grab_pos):
			follow_grab()
		else:
			_get_thrown(_calc_drop())

func _setup(p_ref: Ref):
	actor = p_ref.actor
	physics = p_ref.physics
	collisions = p_ref.collisions

func _get_picked_up(p_grab_pos, p_drop_pos):
	if "velocity" in actor:
		actor.velocity = Vector2.ZERO
	grab_pos = p_grab_pos
	drop_pos = p_drop_pos
	picked_up = true
	_disable_collisions(true)

func pickup_pos():
	return $PickupPos.global_position

func follow_grab():
	var grab_target = grab_pos.global_position
	var pickup_offset = actor.global_position - pickup_pos()
	
	actor.global_position = grab_target + pickup_offset

func _get_put_down():
	actor.velocity = Vector2.ZERO

	var drop_target = drop_pos.global_position
	var pickup_offset = actor.global_position - pickup_pos()

	actor.global_position = drop_target + pickup_offset

	grab_pos = null
	picked_up = false
	_disable_collisions(false)

func _get_thrown(throw: Dictionary):
	if "velocity" in actor:
		actor.velocity = Vector2.ZERO

	var dir = throw.get("direction", Vector2.DOWN)
	var speed = throw.get("speed", 100.0)
	var arc = throw.get("arc", 300.0)
	thrown = true
	picked_up = false
	grab_pos = null
	physics.start_25d_throw(dir, speed, arc)
	_disable_collisions(false)

func _disable_collisions(setting: bool):
	for collision in collisions:
		collision.disabled = setting

func _calc_drop() -> Dictionary:
	var random_angle: float = randf_range(0, TAU)
	var throw_dir: Vector2 = Vector2.RIGHT.rotated(random_angle)
	var random_speed: float = randf_range(50.0, 100)
	
	return {"direction": throw_dir, "speed": random_speed, "arc": 300}
