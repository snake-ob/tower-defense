extends Node
class_name BulletSpawner

@export var BulletScene: PackedScene
@export var bullet: BulletData

var stored_bullet: BulletData

var bullet_ready = false
var active: bool = false
var bullet_timer: Timer
var ref: Ref
var timing: float

func _setup(p_ref):
	ref = p_ref

func _ready():
	bullet_timer = Timer.new()
	add_child(bullet_timer)
	bullet_timer.timeout.connect(func(): bullet_ready = true)
	bullet_timer.start(bullet.timing)
	stored_bullet = bullet.duplicate()
	
func _process(_delta):
	if bullet_ready and ref.detect_zone.active_targets != [] and active:
		spawn_bullet()
		
func spawn_bullet():
	bullet_ready = false
	var new_bullet = BulletScene.instantiate()
	new_bullet.global_position = ref.actor.global_position
	new_bullet.active_targets = ref.detect_zone.active_targets
	new_bullet.attack = ref.attack
	new_bullet.attack.damage = bullet.damage
	new_bullet.move = ref.move
	new_bullet._set_collisions(ref.actor.collision)
	if ref.has('status_upgrades'):
		new_bullet._set_status_upgrades(ref.status_upgrades)
	SignalBus.spawn_bullet.emit(new_bullet)

func upgrade(p_data: Array[TowerUpgrade]):
	# Called every time new rune is slotted into tower

	bullet = stored_bullet.duplicate()
	for upgrade in p_data:
		bullet.damage = bullet.damage * upgrade.damage_multiplier
		bullet.knockback = bullet.knockback * upgrade.damage_multiplier
		bullet.timing = bullet.timing / upgrade.freq_multiplier
	
	if bullet_timer:
		bullet_timer.wait_time = bullet.timing

func activate():
	active = true

func deactivate():
	active = false
