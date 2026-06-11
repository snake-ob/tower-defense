extends Area2D

var overlapping_enemies: Array[Node2D] = []

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	overlapping_enemies.append(body)

func _on_body_exited(body):
	overlapping_enemies.erase(body)
	body.modulate = Color.WHITE 

func _process(_delta):
	if overlapping_enemies.is_empty(): return
	
	var extents = collision_shape.shape.get_rect().size.y / 2
	var zone_top = collision_shape.global_position.y - extents
	var zone_bottom = collision_shape.global_position.y + extents

	var shadow_color = Color("#251815")

	for enemy in overlapping_enemies:
		var enemy_feet_y = enemy.global_position.y
		var percentage = remap(enemy_feet_y, zone_top, zone_bottom, 0.0, 1.0)
		percentage = clamp(percentage, 0.0, 1.0)
		
		if percentage < 0.66:
			enemy.modulate = shadow_color
		elif percentage < 0.90:
			enemy.modulate = shadow_color.lerp(Color.WHITE, 0.5)
		else:
			enemy.modulate = Color.WHITE
