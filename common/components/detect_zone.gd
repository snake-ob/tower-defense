extends Area2D
class_name DetectZone

var actor

var active_targets: Array[Node2D] = []

func _setup(p_ref):
	actor = p_ref.actor

func _ready() -> void:
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)
	if not body_exited.is_connected(_on_body_exited):
		body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if actor is Enemy:
		print("=== GHOST COLLISION DETECTED ===")
		print("Target Name: ", body.name)
		print("Target RID: ", body.get_rid())
		print("DetectZone RID: ", get_rid())
		print("DetectZone Current Mask (Int): ", collision_mask)
		print("Target Current Layer (Int): ", body.collision_layer)
		
		# Let's check the absolute truth from the Physics Server itself
		var space_state = get_world_2d().direct_space_state
		print("Is Physics Server Active? ", not space_state == null)
		print("================================")
	if not active_targets.has(body):
		active_targets.append(body)
		body.tree_exited.connect(func(): active_targets.erase(body))

func _on_body_exited(body: Node2D) -> void:
	if active_targets.has(body):
		active_targets.erase(body)
