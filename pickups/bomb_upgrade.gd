extends CharacterBody2D

@onready var ref: Ref = $Ref
@export var move: MoveData

var upgrades = [
	{'upgrade': 'fire', 'path': ''},
	{'upgrade': 'ice', 'path': ''},
	{'upgrade': 'poison', 'path': ''},
	{'upgrade': 'speed', 'path': ''},
	{'upgrade': 'damage', 'path': ''},
	{'upgrade': 'tower', 'path': ''},
	{'upgrade': 'bombs', 'path': ''},
	{'upgrade': 'caltropes', 'path': ''},
	{'upgrade': 'landmines', 'path': ''}
]

func _ready():
	_setup_ref()
	_setup_nodes(self)
	$StateMachine._set_state('idle')
	await get_tree().create_timer(2).timeout
	_die()
	
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

func _die():
	if has_node("CollisionShape2D"):
		$CollisionShape2D.set_deferred("disabled", true)
	
	var flicker_count = 8
	var flicker_speed = 0.05
	
	for i in range(flicker_count):
		visible = !visible
		await get_tree().create_timer(flicker_speed).timeout
	
	queue_free()
