extends StatusEffect
class_name Freeze

var health: Node
var actor: Node
var hitbox: Area2D
@onready var spread: Spread = $Spread

func _setup(p_ref):
	health = p_ref.health
	actor = p_ref.actor
	hitbox = p_ref.hitbox
	var spread_node = get_node("Spread")
	spread_node._set_collision_shape(hitbox._get_collision_shape())

func _process(delta):
	actor.velocity = actor.velocity/1.2
	
func renew():
	# If lifespan timer, reset it
	pass
