extends State

var pickup: Area2D
var soft_collision: Area2D

func _setup(p_ref):
	pickup = p_ref.pickup
	soft_collision = p_ref.soft_collision

func _update(delta):
	if pickup.picked_up:
		change_state.emit('picked')

func _enter_state():
	soft_collision.enable()
