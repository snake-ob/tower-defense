extends Area2D

var dust_path: String = "res://common/components/Dust.tscn"

func _ready():
	if not body_shape_entered.is_connected(_on_body_shape_entered):
		body_shape_entered.connect(_on_body_shape_entered)
		
func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int):
	if body is TileMapLayer:
		var tilemap = body
		
		var cell = tilemap.get_coords_for_body_rid(body_rid)
		var pos = tilemap.map_to_local(cell)
		
		if tilemap.has_method('break_wall_tile'):
			tilemap.break_wall_tile(cell)
		
		_spawn_dust(pos)
		
func _spawn_dust(_pos: Vector2):
	var dust_scene = load(dust_path)
	var dust = dust_scene.instantiate()
	dust.global_position = _pos
	SignalBus.spawn_bullet.emit(dust)
