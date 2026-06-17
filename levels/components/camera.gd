extends Camera2D

var top_left: Vector2i
var bottom_right: Vector2i
@export var target: Node2D
@export var min_zoom: float = 0.4  # Max zoom OUT (smaller number = further away)
@export var max_zoom: float = 1.0  # Max zoom IN (larger number = closer look)
@export var zoom_speed: float = 0.1 # How much the zoom changes per scroll wheel click
@export var zoom_duration: float = 0.15 # How smooth the animation feels (in seconds)

var target_zoom: Vector2

func _ready():
	target_zoom = zoom

func _setup(p_ref):
	top_left = p_ref.top_left
	bottom_right = p_ref.bottom_right
	update_limits()

func update_limits():	
	limit_left = top_left.x
	limit_top = top_left.y
	limit_right = bottom_right.x
	limit_bottom = bottom_right.y

func _process(_delta):
	if target:
		global_position = target.global_position
		
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_adjust_zoom(zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_adjust_zoom(-zoom_speed)
		
func _adjust_zoom(amount: float) -> void:
	var new_zoom_x = clamp(target_zoom.x + amount, min_zoom, max_zoom)
	var new_zoom_y = clamp(target_zoom.y + amount, min_zoom, max_zoom)
	target_zoom = Vector2(new_zoom_x, new_zoom_y)
	
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "zoom", target_zoom, zoom_duration)
