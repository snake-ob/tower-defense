extends CharacterBody2D

@onready var ref: Ref = $Ref
@export var move: MoveData

var upgrades = [
	{'upgrade': 'fire', 'path': 'res://entities/tower/gems/FireGem.tscn', 'cost': 0},
	{'upgrade': 'ice', 'path': 'res://entities/tower/gems/IceGem.tscn', 'cost': 0},
	{'upgrade': 'poison', 'path': 'res://entities/tower/gems/PoisonGem.tscn', 'cost': 0},
	{'upgrade': 'speed', 'path': 'res://entities/tower/gems/SpeedGem.tscn', 'cost': 0},
	{'upgrade': 'damage', 'path': 'res://entities/tower/gems/AttackGem.tscn', 'cost': 0},
	{'upgrade': 'tower', 'path': 'res://entities/tower/Tower.tscn', 'cost': 0},
	{'upgrade': 'bombs', 'path': 'res://pickups/BombUpgrade.tscn', 'cost': 0},
	{'upgrade': 'caltropes', 'path': 'res://pickups/CaltropeUpgrade.tscn', 'cost': 0},
	{'upgrade': 'landmines', 'path': 'res://pickups/LandmineUpgrade.tscn', 'cost': 0}
]

var upgrade: Dictionary

func _ready():
	_setup_ref()
	_setup_nodes(self)
	upgrade = upgrades.pick_random()
	$StateMachine._set_state('idle')
	
func _setup_ref():
	ref.set('actor', self)
	ref.set('pickup', $Pickup)
	ref.set('physics', $PhysicsHandler)
	ref.set('collisions', [$SoftCollision/CollisionShape2D, $CollisionShape2D])
	ref.set('sprite', $Sprite2D)
	ref.set('soft_collision', $SoftCollision)

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
	# Cost will grow, turn red, and shake for a moment
	pass
