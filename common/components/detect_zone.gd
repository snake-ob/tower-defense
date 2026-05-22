extends Area2D
class_name DetectZone

var active_targets: Array[Node2D] = []

func _ready() -> void:
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)
	if not body_exited.is_connected(_on_body_exited):
		body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if not active_targets.has(body):
		active_targets.append(body)
		body.tree_exited.connect(func(): active_targets.erase(body))

func _on_body_exited(body: Node2D) -> void:
	if active_targets.has(body):
		active_targets.erase(body)
