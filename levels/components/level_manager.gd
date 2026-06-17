extends Node
class_name LevelManager

# Control when the wave appears, and notify HUD
# Control when the wave ends, notify HUD and spawn blueprints
# Control rest. After rest, next level transitions automatically

var time_label: Label
var status_label: Label

var wave_manager: Node
var prep_timer: Timer
var prep_length: float = 10
var wave_timer: Timer
var wave_length: float = 60
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
	active_timer = prep_timer
	prep_timer.start(prep_length)

func _process(_delta):
	var time_left = _get_remaining_time(active_timer)
	time_label.text = time_left

	
func _setup_lvl(p_ref):
	wave_manager = p_ref.wave_manager
	time_label = p_ref.time_left
	status_label = p_ref.status_label
	status_label.text = "Prepare Your Defences"
	
func _prep_timeout():
	wave_manager.start_wave()
	wave_timer.start(wave_length)
	active_timer = wave_timer
	status_label.text = "Protect Your King!"
	
func _wave_timeout():
	# Next prep phase or something
	pass
	

func _get_remaining_time(timer):
	var minutes = int(ceil(timer.time_left)) / 60
	var seconds = int(ceil(timer.time_left)) % 60
	
	return "%d:%02d" % [minutes, seconds]
