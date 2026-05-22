#pickup.gd
extends Area2D
class_name Pickup

var picked_up: bool = false
var grab_pos: Node2D
var drop_pos: Node2D
var actor: Node2D

func _physics_process(delta: float) -> void:
	if picked_up:
		follow_grab()

func _setup(p_ref: Ref):
	actor = p_ref.actor

func _get_picked_up(p_grab_pos, p_drop_pos):
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
	var drop_target = drop_pos.global_position
	var pickup_offset = actor.global_position - pickup_pos()
	
	actor.global_position = drop_target + pickup_offset
	
	grab_pos = null
	picked_up = false
