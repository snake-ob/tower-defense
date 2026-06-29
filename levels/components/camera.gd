extends Camera2D

var top_left: Vector2i
var bottom_right: Vector2i

var catching_up_to: Node2D = null

@export var target: Node2D
@export var min_zoom: float = 0.4  # Max zoom OUT (smaller number = further away)
@export var max_zoom: float = 1.0  # Max zoom IN (larger number = closer look)
@export var zoom_speed: float = 0.1 # How much the zoom changes per scroll wheel click
@export var zoom_duration: float = 0.15 # How smooth the animation feels (in seconds)
@export var catch_up_speed: float = 100.0 # Pixels per second
@export var arrival_tolerance: float = 1.0 # How close is "close enough" (in pixels)

var target_zoom: Vector2

func _ready():
	target_zoom = zoom
	SignalBus.camera_new_target.connect(set_target)

func _setup(p_ref):
	top_left = p_ref.top_left
	bottom_right = p_ref.bottom_right
	update_limits()

func update_limits():	
	limit_left = top_left.x
	limit_top = top_left.y
	limit_right = bottom_right.x
	limit_bottom = bottom_right.y

func _process(delta):
	if catching_up_to and is_instance_valid(catching_up_to):
		var target_pos = catching_up_to.global_position
		
		global_position = global_position.move_toward(target_pos, catch_up_speed * delta)
		
		if global_position.distance_to(target_pos) <= arrival_tolerance:
			target = catching_up_to
			catching_up_to = null

	elif target and is_instance_valid(target):
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
	
func zoom_all_the_way_out(custom_duration: float = 3.0) -> void:
	target_zoom = Vector2(min_zoom, min_zoom)
	var zoom_tween: Tween
		
	zoom_tween = create_tween()
	zoom_tween.set_ease(Tween.EASE_OUT)
	
	zoom_tween.set_trans(Tween.TRANS_SINE) 
	
	zoom_tween.tween_property(self, "zoom", target_zoom, custom_duration)


func zoom_all_the_way_in(custom_duration: float = 2.0) -> void:
	target_zoom = Vector2(max_zoom, max_zoom)
	var zoom_tween: Tween
		
	zoom_tween = create_tween()
	zoom_tween.set_ease(Tween.EASE_OUT)
	
	zoom_tween.set_trans(Tween.TRANS_SINE) 
	
	zoom_tween.tween_property(self, "zoom", target_zoom, custom_duration)

func set_target(new_target: Node2D):
	if new_target == null:
		target = null
		catching_up_to = null
		return
		
	catching_up_to = new_target
	target = null
