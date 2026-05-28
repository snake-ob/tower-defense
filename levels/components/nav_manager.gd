extends Node2D
class_name NavManager

var pathfinder: AStarGrid2D = AStarGrid2D.new()

func _ready() -> void:
	pathfinder.region = Rect2i(0, 0, 100, 100)
	
	pathfinder.cell_size = Vector2i(16, 16)
	
	pathfinder.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_AT_LEAST_ONE_WALKABLE
	
	pathfinder.update()
