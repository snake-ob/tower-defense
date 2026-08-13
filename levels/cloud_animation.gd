extends AnimationPlayer


func _ready() -> void:
	pass # Replace with function body.


func play_sequence() -> void:
	anim_player.play("fly_in")    # Starts immediately
	anim_player.queue("idle")      # Plays right after 'fly_in' finishes
