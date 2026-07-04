extends Node

var active_state: String = ""
var neutral_state: String = ""
var states = ['prepping', 'defending', 'shopping', 'king_taken', 'king_picked', 'lvl_over']
var neutral_states = ['prepping', "defending", "lvl_over"]

signal new_state

func set_active_state(_state: String) -> void:
	var state = _state.to_lower()
	if state in states:
		active_state = state
		if state in neutral_states:
			neutral_state = state
	else:
		print("DiagBus: State '", _state, "' not valid.")

func reset_state():
	set_active_state(neutral_state)
