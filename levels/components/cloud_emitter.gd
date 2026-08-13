extends Node2D
class_name CloudEmitter

var cloud_path: String = "res://levels/components/Cloud.tscn"
var emit_timer: Timer
@export var min_speed: int = 100
@export var max_speed: int = 300

func _ready() -> void:
	emit_timer = Timer.new()
	emit_timer.timeout.connect(_on_emit)
	add_child(emit_timer)
	emit_timer.start(random_time())
	
	
func random_time() -> float:
	return randf_range(0.3, 1.5)
	
func random_speed() -> int:
	return randi_range(min_speed, max_speed)

func _on_emit() -> void:
	var cloud_scene = load(cloud_path)
	var cloud = cloud_scene.instantiate()
	var y_pos = randi_range(0, 144)
	cloud.global_position = Vector2(344, y_pos)
	cloud.speed = random_speed()
	
	add_child(cloud)
	emit_timer.start(random_time())
