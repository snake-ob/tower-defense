extends State

var detect_zone

func _ready():
	pass

func _enter_state():
	pass
	
func _setup(p_ref):
	detect_zone = p_ref.detect_zone

func _update(delta):
	if detect_zone.active_targets > 0:
		_on_explode()

func _on_explode():
	change_state.emit('explode')
