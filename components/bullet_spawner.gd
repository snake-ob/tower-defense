extends Node
class_name BulletSpawner

@export var Bullet: PackedScene

#export out as resources
var bullet_timing: float = 3.0
var bullet_speed: int = 200
var bullet_ready = false

var bullet_timer: Timer

var ref: Ref = null

func _setup(p_ref):
	ref = p_ref

func _ready():
	bullet_timer = Timer.new()
	add_child(bullet_timer)
	bullet_timer.timeout.connect(func(): bullet_ready = true)
	
func _process(_delta):
	if bullet_ready:
		spawn_bullet()
		
func spawn_bullet():
	var new_bullet = Bullet.instantiate()
	new_bullet.global_position = ref.actor.global_position
	SignalBus.send_bullet.emit(new_bullet)
