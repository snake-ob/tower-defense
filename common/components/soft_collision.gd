extends Area2D
class_name SoftCollision

@export var push_force: float = 1500

var actor: Node2D
var mass: float = 10
var overlapping_areas: Array = []

func _setup(p_ref: Ref) -> void:
	if p_ref.has('mass'):
		mass = p_ref.mass
	actor = p_ref.actor

func _ready() -> void:	
	if not area_entered.is_connected(_on_area_entered):
		area_entered.connect(_on_area_entered)
	if not area_exited.is_connected(_on_area_exited):
		area_exited.connect(_on_area_exited)

func _on_area_entered(area: Area2D):
	if not overlapping_areas.has(area):
		overlapping_areas.append(area)
		area.tree_exited.connect(func(): overlapping_areas.erase(area))

func _on_area_exited(area: Area2D):
	if overlapping_areas.has(area):
		overlapping_areas.erase(area)

func _physics_process(delta):
	if overlapping_areas == []:
		return

	for area in overlapping_areas:
		calculate_push(area, delta)

func calculate_push(other_area: Area2D, delta) -> void:
	if other_area is SoftCollision:
		var other: SoftCollision = other_area
		
		var push_direction = global_position.direction_to(other.global_position)
		
		if push_direction == Vector2.ZERO:
			push_direction = Vector2.UP.rotated(randf() * TAU)
			
		var total_mass = mass + other.mass
		var mass_influence = mass / total_mass if total_mass > 0 else 0.5
		
		var velocity_bonus: float = 0.0
		
		var my_vel = actor.velocity if "velocity" in actor else Vector2.ZERO
		var other_vel = other.actor.velocity if "velocity" in other.actor else Vector2.ZERO
		
		var my_approach_speed = my_vel.dot(push_direction)
		var other_approach_speed = other_vel.dot(-push_direction) # From their perspective
		
		if my_approach_speed > other_approach_speed:
			velocity_bonus = my_approach_speed - other_approach_speed
				
		var total_force = push_force + (velocity_bonus * mass_influence)
		var shove_vector = push_direction * total_force * delta * mass_influence
		
		if other.has_method("_get_push"):
			other._get_push(shove_vector)

func _get_push(p_shove):
	actor.velocity += p_shove
