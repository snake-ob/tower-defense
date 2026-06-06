extends Camera2D

var top_left: Vector2i
var bottom_right: Vector2i
@export var target: Node2D

func _setup(p_ref):
	top_left = p_ref.top_left
	bottom_right = p_ref.bottom_right
	update_limits()

func update_limits():
	# Debug print to Output window so we can see the values
	print("Camera limits setting to: TL:", top_left, " BR:", bottom_right)
	
	limit_left = top_left.x
	limit_top = top_left.y
	limit_right = bottom_right.x
	limit_bottom = bottom_right.y

func _process(_delta):
	if target:
		# Use global_position to match the player exactly
		global_position = target.global_position
