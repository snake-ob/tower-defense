extends RayCast2D
class_name WallDetector

var active_targets: Array
var actor: Node2D
var size: float = 15
var ref

func _setup(_ref):
	ref = _ref
	actor = _ref.actor
	
func _physics_process(delta: float) -> void:
	if ref.active_targets.size() <= 0:
		return
	var target = ref.active_targets[0]
	var dir = actor.global_position.direction_to(target.global_position)
	target_position = dir*size
