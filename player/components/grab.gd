extends Area2D

@onready var grab_pos = $GrabPos
@onready var drop_pos = $DropPos
@onready var drop_anchor: Vector2 = $DropPos.position

var grabbable_objects: Array = []
var grabbed_pickup: Node2D
var actor: Node2D

func _ready():
	if not area_entered.is_connected(_on_area_entered):
		area_entered.connect(_on_area_entered)
	if not area_exited.is_connected(_on_area_exited):
		area_exited.connect(_on_area_exited)

func _setup(p_ref: Ref):
	actor = p_ref.actor

func _on_area_entered(area: Node2D):
	if area not in grabbable_objects:
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
	pickup._get_picked_up(grab_pos, drop_pos)
	grabbed_pickup = pickup
	
func _put_down():
	grabbed_pickup._get_put_down()
	grabbed_pickup = null
