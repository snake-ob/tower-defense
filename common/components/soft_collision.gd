extends Area2D
class_name SoftCollision

@export var push_force: float = 150.0
@onready var collision_shape = $CollisionShape2D

var max_distance = 30
var actor: CharacterBody2D

func _ready() -> void:
	actor = get_parent() as CharacterBody2D

func _physics_process(_delta: float) -> void:
	var areas = get_overlapping_areas()
	if areas.is_empty():
		return
		
	for area in areas:
		if area is SoftCollision:
			var distance = global_position.distance_to(area.global_position)
			
			# If they are exactly on center, give them a tiny random nudge so distance isn't 0
			if distance == 0:
				var random_dir = Vector2.UP.rotated(randf() * TAU)
				area._get_pushed(random_dir, push_force)
				continue
			
			# If they are further away than max_distance, ignore the push entirely
			if distance >= max_distance:
				continue
				
			# DIRECTION FIX: Points from us, towards them (pushing them AWAY)
			var dir = global_position.direction_to(area.global_position)
			
			# FORCE FIX: Calculates the high force at close distance
			var calculated_force = (max_distance - distance) * push_force
			
			# Send the push vector scaled by our calculated dynamic force
			area._get_pushed(dir, calculated_force)

func _get_pushed(p_vector, p_force):
	# Apply the smooth dynamic force to the actor's velocity
	actor.velocity += p_vector.normalized() * p_force
	

func enable() -> void:
	if collision_shape:
		collision_shape.set_deferred("disabled", false)

func disable() -> void:
	if collision_shape:
		collision_shape.set_deferred("disabled", true)
