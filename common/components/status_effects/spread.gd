extends Area2D
class_name Spread

@onready var status = load(get_parent().scene_file_path)

var close_entities: Array
var actor: Node2D

func _setup(p_ref):
	actor = p_ref.actor

func _ready() -> void:
	if not area_entered.is_connected(_area_entered):
		area_entered.connect(_area_entered)
	if not area_exited.is_connected(_area_exited):
		area_exited.connect(_area_exited)

func _area_entered(area: Hurtbox):
	if area in close_entities:
		return
	if area.get_owner_actor() == actor:
		return
	close_entities.append(area)
	area.tree_exited.connect(func(): close_entities.erase(area))

func _area_exited(area: Hurtbox):
	if area in close_entities:
		close_entities.erase(area)

func _set_collision_shape(p_shape: Shape2D):
	$CollisionShape2D.shape = p_shape

func spread_effect():
	for entity in close_entities:
		var hit = {"damage": 0, "knockback": 0, "status_effects": [status], "position": global_position}
		entity.take_hit(hit)
