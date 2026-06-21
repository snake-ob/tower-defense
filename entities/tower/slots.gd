extends Area2D

var slots: Array[Rune] = [null, null]
var upgrades: Node
var bullet_spawner: BulletSpawner

func _ready():
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)
	if not body_exited.is_connected(_on_body_exited):
		body_exited.connect(_on_body_exited)
		
	slots.resize(2)

func _setup(p_ref):
	upgrades = p_ref.upgrades
	bullet_spawner = p_ref.bullet_spawner

func _on_body_entered(body):
	body.transfer_gem(self)

func _on_body_exited(body):
	pass

func slot_rune(p_rune):
	add_child(p_rune)
	if slots[1] != null:
		remove_upgrade(slots[1])
	if slots[0] != null:
		slots[1] = slots[0]
		slots[1].position = $PosTwo.position
		
	slots[0] = p_rune
	slots[0].position = $PosOne.position
	
	add_upgrade(p_rune)
	_upgrade_spawner.call_deferred()
	
func add_upgrade(p_rune):
	var upgrade_scene = load(p_rune.upgrade)
	var upgrade = upgrade_scene.instantiate()
	upgrade.unique_id = p_rune.unique_id
	upgrades.add_child(upgrade)
	
func remove_upgrade(p_rune):
	p_rune.eject()
	for upgrade in upgrades.get_children():
		if upgrade.unique_id == p_rune.unique_id:
			upgrade.queue_free()

func _upgrade_spawner():
	var tower_upgrades: Array[TowerUpgrade] = []
	for upgrade in upgrades.get_children():
		if upgrade.is_queued_for_deletion(): continue
		var tower_upgrade = upgrade._get_upgrade()
		if tower_upgrade != null: tower_upgrades.append(tower_upgrade)
	bullet_spawner.upgrade(tower_upgrades)
