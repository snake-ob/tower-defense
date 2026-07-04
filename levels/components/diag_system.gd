extends Node
class_name DiagSystem

# Set a timer in a random range that will set a dialogue 
# 

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

func _ready():
	#SignalBus.king_taken().connect()
	pass

func _setup_lvl(p_ref):
	speech_bubble = p_ref.speech_bubble
	
	_set_diag()
	
func _set_diag():
	var active_diag = prepping[0]
	speech_bubble.set_bubble(active_diag)
