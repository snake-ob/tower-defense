extends Node
class_name DiagSystem

# Set a timer in a random range that will set a dialogue 
# 

# -- SIGNALS --
# King Taken | Shopping

# -- FLAGS --
# King being taken | King being carried by player | Level Over
@export var taken_pool: Array[DiagData]

var speech_bubble: SpeechBubble

func _setup_lvl(p_ref):
	speech_bubble = p_ref.speech_bubble
	
	speech_bubble.set_bubble_text("Hello my boy")
	speech_bubble.active = true
	speech_bubble.set_bubble_graphic("rmb")
	
