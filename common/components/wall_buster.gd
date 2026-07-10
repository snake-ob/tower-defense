extends Area2D

func _ready():
	# Connect to body_shape_entered instead of body_entered
	if not body_shape_entered.is_connected(_on_body_shape_entered):
		body_shape_entered.connect(_on_body_shape_entered)
		
func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int):
	if body is TileMapLayer:
		var tilemap = body
		
		# Pass the specific collision RID to get the exact grid coordinate
		var cell = tilemap.get_coords_for_body_rid(body_rid)
		
		if tilemap.has_method('break_wall_tile'):
			tilemap.break_wall_tile(cell)
		
		_spawn_dust()
		
func _spawn_dust():
	pass
