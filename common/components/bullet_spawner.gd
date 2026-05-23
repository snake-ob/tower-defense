extends Node
class_name BulletSpawner

@export var BulletScene: PackedScene
@export var bullet: BulletData

var bullet_ready = false
var active: bool = false
var bullet_timer: Timer
var ref: Ref

func _setup(p_ref):
	ref = p_ref

func _ready():
	bullet_timer = Timer.new()
	add_child(bullet_timer)
	bullet_timer.timeout.connect(func(): bullet_ready = true)
	bullet_timer.start(bullet.timing)
	
func _process(_delta):
	if bullet_ready and ref.detect_zone.active_targets != [] and active:
		spawn_bullet()
		
func spawn_bullet():
	bullet_ready = false
	var new_bullet = BulletScene.instantiate()
	new_bullet.global_position = ref.actor.global_position
	new_bullet.active_targets = ref.detect_zone.active_targets
	new_bullet.attack = ref.attack
	new_bullet.move = ref.move
	new_bullet._set_collisions(ref.actor.collision)
	SignalBus.spawn_bullet.emit(new_bullet)

func activate():
	active = true

func deactivate():
	active = false
