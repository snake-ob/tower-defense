extends CharacterBody2D
class_name RoyalDecree

@onready var ref: Ref = $Ref
@export var move: MoveData
@export var upgrades: Array[UpgradeData]

var upgrade: UpgradeData

func _ready():
	_setup_ref()
	_setup_nodes(self)
	upgrade = _pick_weighted_upgrade(upgrades)
	$StateMachine._set_state('idle')
	ref.shop.set_shop(upgrade)
	
func _setup_ref():
	ref.set('actor', self)
	ref.set('pickup', $Pickup)
	ref.set('physics', $PhysicsHandler)
	ref.set('collisions', [$SoftCollision/CollisionShape2D, $CollisionShape2D])
	ref.set('sprite', $Sprite2D)
	ref.set('soft_collision', $SoftCollision)
	ref.set('shop', $PurchaseScreen)
	
func _physics_process(delta):
	move_and_slide()
	
func _pick_weighted_upgrade(p_upgrades: Array[UpgradeData]) -> UpgradeData:
	if p_upgrades.is_empty():
		return null
		
	var total_weight: int = 0
	for u in p_upgrades:
		total_weight += u.chance
		
	var random_weight = randi_range(1, total_weight)
	
	var current_sum: int = 0
	for u in p_upgrades:
		current_sum += u.chance
		if random_weight <= current_sum:
			return u
			
	print("WEIGHTED UPGRADE MALFUNCTION")
	return p_upgrades[0]
	

func _setup_nodes(p_node):
	for node in p_node.get_children():
		if node.has_method('_setup'):
			node._setup(ref)
		if node.get_child_count() > 0:
			_setup_nodes(node)

func purchase_requested():
	if Inventory.wallet < upgrade.cost:
		deny_purchase()
		return
	Inventory.wallet -= upgrade.cost
	var upgrade_scene = load(upgrade.path)
	var upgrade_item = upgrade_scene.instantiate()
	upgrade_item.global_position = global_position
	if upgrade_item is Tower:
		upgrade_item.register_tower()
	SignalBus.spawned.emit(upgrade_item)
	Score.update('item_purchased')
	queue_free()

func deny_purchase():
	ref.shop.insufficient_funds()
	pass
