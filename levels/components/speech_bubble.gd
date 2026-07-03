extends PanelContainer

@onready var label = $Label # Ensure this path is correct

var text: String:
	set(value):
		text = value
		if label:
			label.text = value
			# Force the container to re-calculate its size 
			# based on the new content size
			call_deferred("reset_size")
