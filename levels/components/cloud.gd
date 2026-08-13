extends Node2D
class_name Cloud

@export var speed: int = 10

func _ready():
	# Set random cloud
	var sprite = $AnimatedSprite2D
	sprite.stop()
	sprite.frame = randi() % sprite.sprite_frames.get_frame_count(sprite.animation)

func _process(delta: float) -> void:
	position.x -= speed * delta
	
	if position.x < -200: 
		queue_free()
