extends Area2D
class_name DetectZone

var active_targets: Array[Node2D] = []

func _on_body_entered(body: Node2D) -> void:
	if body is not Enemy:
		return
	if not active_targets.has(body):
		active_targets.append(body)
		body.tree_exited.connect(func(): active_targets.erase(body))

func _on_body_exited(body: Node2D) -> void:
	if active_targets.has(body):
		active_targets.erase(body)
