extends AnimatedSprite2D

func trigger_flicker() -> void:
	var shader_material = material as ShaderMaterial
	if not shader_material:
		return
		
	var tween = create_tween()
	
	for i in range(2):
		tween.tween_method(func(val): shader_material.set_shader_parameter("active", val), true, true, 0.1)
		tween.tween_method(func(val): shader_material.set_shader_parameter("active", val), false, false, 0.1)
