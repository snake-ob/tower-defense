extends CharacterBody2D

@onready var ref: Ref = $Ref
@export var move: MoveData
@export var upgrades: Array[UpgradeData]

var upgrade: UpgradeData

func _ready():
	_setup_ref()
	_setup_nodes(self)
	upgrade = upgrades.pick_random()
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
	var upgrade_scene = load(upgrade.path)
	var upgrade_item = upgrade_scene.instantiate()
	upgrade_item.global_position = global_position
	SignalBus.spawned.emit(upgrade_item)
	queue_free()

func deny_purchase():
	ref.shop.insufficient_funds()
	pass
