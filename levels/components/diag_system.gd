extends Node
class_name DiagSystem

# Set a timer in a random range that will set a dialogue 

# -- SIGNALS --
# King Taken | Shopping

# -- FLAGS --
# King being taken | King being carried by player | Level Over
@export var prepping: Array[DiagData]
@export var defending: Array[DiagData]
@export var king_taken: Array[DiagData]
@export var king_picked: Array[DiagData]
@export var lvl_over: Array[DiagData]
@export var shopping: Array[DiagData]

var speech_bubble: SpeechBubble
var context_timer: Timer

func _ready():
	context_timer = Timer.new()
	context_timer.one_shot = true
	context_timer.timeout.connect(_set_context_diag)
	add_child(context_timer)
	
	DiagBus.new_state.connect(_set_context_diag)
	_set_context_timer()

func _setup_lvl(p_ref):
	speech_bubble = p_ref.speech_bubble

func _set_context_diag():
	context_timer.stop()
	var context_diag: DiagData = null
	match DiagBus.active_state:
		"prepping":
			context_diag = prepping.pick_random()
		"defending":
			context_diag = defending.pick_random()
		"shopping":
			context_diag = shopping.pick_random()
		"king_taken":
			context_diag = king_taken.pick_random()
		"king_picked":
			context_diag = king_picked.pick_random()
		"lvl_over":
			context_diag = lvl_over.pick_random()
	if context_diag == null:
		print("Diag not found. Active state is : ", DiagBus.active_state)
		return
		
	speech_bubble.set_bubble(context_diag)
	_set_context_timer()
	
func _set_context_timer():
	var time = randf_range(5, 20)
	context_timer.start(time)
