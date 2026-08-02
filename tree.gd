extends StaticBody2D

@export_enum("carniferous", "bushy", "dead") var tree_type: String = "bushy"

func _ready():
	var sprite = $AnimatedSprite2D
	if not sprite or not sprite.sprite_frames:
		return
		
	# 1. Stop playback first to prevent autoplay overrides
	sprite.stop()
	
	# 2. Assign the animation strip
	if sprite.sprite_frames.has_animation(tree_type):
		sprite.animation = tree_type
		
		var total_frames = sprite.sprite_frames.get_frame_count(tree_type)
		if total_frames > 0:
			# 3. Use position + time to guarantee a unique seed per tree instance
			var rng = RandomNumberGenerator.new()
			rng.seed = hash(global_position) + Time.get_ticks_usec()
			
			# 4. Set the frame LAST after animation is set
			var chosen_frame = rng.randi_range(0, total_frames - 1)
			sprite.frame = chosen_frame
