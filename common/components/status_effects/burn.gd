extends StatusEffect
class_name Burn

var health: Node
var actor: Node
var hitbox: Area2D
var burn_timer: Timer
@export var burn_time: float = 2
@export var burn_damage: int = 1
@export var burn_knockback: int = 2
@onready var spread: Spread = $Spread

func _setup(p_ref):
	health = p_ref.health
	actor = p_ref.actor
	hitbox = p_ref.hitbox
	var spread_node = get_node("Spread")
	spread_node._set_collision_shape(hitbox._get_collision_shape())

func _ready():
	burn_timer = Timer.new()
	add_child(burn_timer)
	burn_timer.timeout.connect(_burn)
	burn_timer.start()

func _burn():
	health._take_damage(burn_damage)
	actor.velocity = actor.velocity / burn_knockback
	spread.spread_effect()

func renew():
	# If lifespan timer, reset it
	pass
	
