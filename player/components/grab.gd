# Grab.gd
extends Area2D
class_name Grab

# --- Grab interface node. Detects grabbable objects in vicinity. Contains the grab slot. Speaks to Pickup interface.

@onready var grab_pos = $GrabPos
@onready var drop_pos = $DropPos
@onready var drop_anchor: Vector2 = $DropPos.position

var grabbable_objects: Array = []
var grabbed_pickup: Node2D = null
var direction: Vector2 = Vector2.ZERO
var actor: Node2D
var drop_distance: int = 32

@export var hand_offset_y: float = 0.0

func _ready():
	if not area_entered.is_connected(_on_area_entered):
		area_entered.connect(_on_area_entered)
	if not area_exited.is_connected(_on_area_exited):
		area_exited.connect(_on_area_exited)

func _setup(p_ref: Ref):
	actor = p_ref.actor

func _physics_process(delta):
	var actor_pos = Vector2(actor.global_position.x, actor.global_position.y - hand_offset_y)

	direction = actor_pos.direction_to(get_global_mouse_position())
	drop_pos.position = drop_anchor + (drop_distance * direction)

func _on_area_entered(area: Node2D):
	if area not in grabbable_objects:
		if area.owner == owner:
			return
		grabbable_objects.append(area)
		area.tree_exited.connect(func(): grabbable_objects.erase(area))

func _on_area_exited(area: Node2D):
	if area in grabbable_objects:
		grabbable_objects.erase(area)
		
func get_grab_pos() -> Node2D:
	return $GrabPos
	
func get_grabbable() -> Array:
	return grabbable_objects
	
func _pickup_object(pickup):
	pickup._get_picked_up(grab_pos, drop_pos, actor)
	grabbed_pickup = pickup
	
func _put_down():
	grabbed_pickup._get_put_down()
	grabbed_pickup = null
	
func _drop(p_drop: Dictionary = {}):
	var random_angle: float = randf_range(0, TAU)
	var throw_dir: Vector2 = p_drop.get('direction', Vector2.RIGHT.rotated(random_angle))
	var speed: float = p_drop.get('speed', randf_range(1.0, 1.5))
	var arc: int = p_drop.get('arc', 300)
	
	var drop_throw = {"direction": throw_dir, "speed": speed, 'arc': arc}
	if grabbed_pickup:
		grabbed_pickup._get_thrown(drop_throw)
	grabbed_pickup = null

func _throw():
	grabbed_pickup._get_thrown({'direction': direction})
	grabbed_pickup = null
