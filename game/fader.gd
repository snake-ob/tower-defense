extends Node
class_name Fader

var actor: Node
var fade_progress: float = 0.0
var fading_in: bool = false
var fading_out: bool = false
@export var fade_speed: float = 0.01 # Adjust this up/down in inspector to change step speed

signal fade_in_finished()
signal fade_out_finished()

func _process(delta: float) -> void:
	if fading_in:
		animate_fade_in()
	elif fading_out:
		animate_fade_out()

func fade_in():
	if fading_out: fading_out = false
	fading_in = true
	fade_progress = 0.0

func fade_out():
	if fading_in: fading_in = false
	fading_out = true
	fade_progress = 0.0

func animate_fade_in():
	var shadow_color = Color("#000000")
	fade_progress += fade_speed
	fade_progress = clamp(fade_progress, 0.0, 1.0)
		
	if fade_progress < 0.33:
		modulate_items(shadow_color)
	elif fade_progress < 0.66:
		modulate_items(shadow_color.lerp(Color.WHITE, 0.5))
	else:
		modulate_items(Color.WHITE)
		fading_in = false
		fade_in_finished.emit() # Tells Credits to start the hold timer!
		
func animate_fade_out():
	var shadow_color = Color("#000000")
	fade_progress += fade_speed
	fade_progress = clamp(fade_progress, 0.0, 1.0)
		
	if fade_progress < 0.33:
		modulate_items(Color.WHITE)
	elif fade_progress < 0.66:
		modulate_items(shadow_color.lerp(Color.WHITE, 0.5))
	else:
		modulate_items(shadow_color)
		fading_out = false
		fade_out_finished.emit() # Tells Credits to move to the next item!
		
func modulate_items(p_color):
	if not actor: return
	for node in actor.get_node("Items").get_children():
		if 'modulate' in node:
			node.modulate = p_color
