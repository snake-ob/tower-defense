extends Node
class_name AniManager

var input_controller: Node
var input_axis: Vector2
var target: Vector2i
var actor: Node
var sprite: Node
var grab: Node

var dead: bool = false

func _setup(p_ref):
	target = p_ref.target
	actor = p_ref.actor
	sprite = p_ref.sprite
	grab = p_ref.grab
		
func _physics_process(delta):
	if dead:
		return
		
	target = actor.ref.target
	var look_dir = Vector2.ZERO
	if target:
		look_dir = actor.global_position.direction_to(target)
		
	update_animation_state(actor.velocity, look_dir)

func update_animation_state(velocity: Vector2, direction: Vector2):
	if direction.x > 0:
		sprite.flip_h = true
	elif direction.x < 0:
		sprite.flip_h = false
		
	var state = 'idle'
	
	if grab.grabbed_pickup != null:
		if velocity != Vector2.ZERO: state = "carry"
		else: state = "hold"
	else:
		if velocity != Vector2.ZERO: state = "walk"
		else: state = "idle"
	
	var dir = "f"
	
	if direction.y < -0.1:
		dir = "b"
	elif direction.y > 0.1:
		dir = "f"
	
	var state_string = dir + '_' + state
	
	if sprite.animation != state_string:
		var current_frame = sprite.frame
		var current_progress = sprite.frame_progress
		sprite.play(state_string)

		sprite.set_frame_and_progress(current_frame, current_progress)
		
func play_death():
	if dead: 
		return
		
	dead = true
	var dir = "f"
	if target:
		var look_dir = actor.global_position.direction_to(target)
		if look_dir.y < -0.1:
			dir = "b"
			
	sprite.play(dir + "_die")
