extends MarginContainer

@onready var bubble = $Panel/NinePatchRect
@onready var label = $Panel/Label

func _ready():
	set_text("Howdy there, partneroo.")

func set_text(new_text: String):
	# 1. Enforce max character limit
	var max_chars = 50
	if new_text.length() > max_chars:
		new_text = new_text.left(max_chars) + "..."
	
	label.text = new_text
	
	# 2. Wait for the label to update its size
	await get_tree().process_frame 
	
	# 3. Resize the NinePatchRect to match the label
	# Add a little padding (e.g., +10 pixels) so the text isn't touching the edges
	bubble.size = label.size + Vector2(10, 10)
