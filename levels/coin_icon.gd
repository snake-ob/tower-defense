extends AnimatedSprite2D

var spins_queued: int = 0

func _ready() -> void:
	animation_finished.connect(_on_animation_finished)
	play("default")

func spin() -> void:
	spins_queued += 1
	
	if animation != "spin":
		play("spin")

func _on_animation_finished() -> void:
	if animation == "spin":
		spins_queued -= 1
		
		if spins_queued > 0:
			play("spin")
		else:
			play("default")
