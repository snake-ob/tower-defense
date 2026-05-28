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

func _physics_process(delta: float) -> void:
	if picked_up:
		follow_grab()

func _setup(p_ref: Ref):
	actor = p_ref.actor
	physics = p_ref.physics

func _get_picked_up(p_grab_pos, p_drop_pos):
	actor.velocity = Vector2.ZERO
	grab_pos = p_grab_pos
	drop_pos = p_drop_pos
	picked_up = true

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

func _get_thrown(throw: Dictionary):
	actor.velocity = Vector2.ZERO

	var dir = throw.get("direction", Vector2.DOWN)
	var speed = throw.get("speed", 500.0)
	var arc = throw.get("arc", 300.0)
	thrown = true
	picked_up = false
	grab_pos = null
	physics.start_25d_throw(dir, speed, arc)
