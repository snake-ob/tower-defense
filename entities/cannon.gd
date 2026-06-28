extends CharacterBody2D
class_name Cannon

@onready var ref: Ref = $Ref

func _ready():
	_setup_ref()
	_setup_nodes(self)
	$StateMachine._set_state('spawn')

	
func _setup_ref():
	ref.set('actor', self)
	ref.set('detect_zone', $DetectZone)
	ref.set('holding_zone', $HoldingZone)
	ref.set('player_card', $PlayerCard)
	ref.set('king_card', $KingCard)
	ref.set('sprite', $AnimatedSprite2D)
	ref.set('soft_collision', $SoftCollision)
	
func _setup_nodes(p_node):
	for node in p_node.get_children():
		if node.has_method('_setup'):
			node._setup(ref)
		if node.get_child_count() > 0:
			_setup_nodes(node)

func set_holding_zone(p_pos: Vector2):
	$HoldingZone.global_position = p_pos
