extends Node2D

var unavailable_color = Color(0.34, 0.34, 0.34, 0.47)

func set_item_ui(p_texture):
	if p_texture:
		$Item.texture = p_texture
		$Item.visible = true
	else:
		$Item.texture = null
		$Item.visible = false

func set_modulation(a: bool):
	if a:
		$Item.modulate(unavailable_color)
	else:
		$Item.modulate(Color.WHITE)
