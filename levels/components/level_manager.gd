extends Node
class_name LevelManager

# Control when the wave appears, and notify HUD
# Control when the wave ends, notify HUD and spawn blueprints  
# Control rest. After rest, next level transitions automatically

@export var waves: Array[WaveData] = []

var time_label: Label
var status_label: Label
var entity_root: Node2D

var decree_path: String = "res://entities/RoyalDecree.tscn"

var wave_manager: Node
var prep_timer: Timer
var prep_length: float = 2
var wave_timer: Timer
var wave_length: float = 3
var rest_timer: Timer
var rest_length: Timer

var active_timer: Timer

func _ready():
	prep_timer = Timer.new()
	prep_timer.timeout.connect(_prep_timeout)
	add_child(prep_timer)
	wave_timer = Timer.new()
	wave_timer.timeout.connect(_wave_timeout)
	add_child(wave_timer)
	prep_timer.one_shot = true
	wave_timer.one_shot = true
	active_timer = prep_timer
	prep_timer.start(prep_length)

func _process(_delta):
	var time_left = _get_remaining_time(active_timer)
	time_label.text = time_left
	
func _setup_lvl(p_ref):
	wave_manager = p_ref.wave_manager
	time_label = p_ref.time_left
	status_label = p_ref.status_label
	status_label.text = "Prepare.."
	entity_root = p_ref.entity_root
	
func _prep_timeout():
	wave_manager.start_wave()
	wave_timer.start(wave_length)
	active_timer = wave_timer
	status_label.text = "Protect Your King!"
	
func _wave_timeout():
	var king_pos = entity_root.get_king_pos()
	for i in range(3):
		var decree_scene = load(decree_path)
		var decree = decree_scene.instantiate()
		decree.global_position = king_pos
		SignalBus.spawned.emit(decree)


func _get_remaining_time(timer):
	var minutes = int(ceil(timer.time_left)) / 60
	var seconds = int(ceil(timer.time_left)) % 60
	
	return "%d:%02d" % [minutes, seconds]
