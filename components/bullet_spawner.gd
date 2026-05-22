extends Node
class_name BulletSpawner

@export var Bullet: PackedScene

#export out as resources
var bullet_timing: float = 1.0
var bullet_speed: int = 200
var bullet_ready = false
var enemy_detected = false

var bullet_timer: Timer

var ref: Ref

func _setup(p_ref):
	ref = p_ref

func _ready():
	bullet_timer = Timer.new()
	add_child(bullet_timer)
	bullet_timer.timeout.connect(func(): bullet_ready = true)
	bullet_timer.start(bullet_timing)
	
func _process(_delta):
	if bullet_ready and ref.detect_zone.active_targets != []:
		spawn_bullet()
		
func spawn_bullet():
	bullet_ready = false
	var new_bullet = Bullet.instantiate()
	new_bullet.global_position = ref.actor.global_position
	new_bullet.active_targets = ref.detect_zone.active_targets
	new_bullet.attack = ref.attack
	new_bullet.move = ref.move
	SignalBus.spawn_bullet.emit(new_bullet)
