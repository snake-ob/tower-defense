extends HBoxContainer

const RED_HEART = preload("res://assets/sprites/objects/red_heart.tres")
const GREY_HEART = preload("res://assets/sprites/objects/grey_heart.tres")

# Set the max health of the player
@export var max_health: int = 3

func _ready():
	initialize_hearts(max_health)
	
	SignalBus.player_hit.connect(_on_player_hit)
	SignalBus.player_spawned.connect(_on_player_spawn)
	_draw_hearts(max_health)

func initialize_hearts(count: int):
	# Clear any existing hearts
	for child in get_children():
		child.queue_free()

	# Create new TextureRects
	for i in range(count):
		var heart = TextureRect.new()
		heart.texture = RED_HEART
		# Set expand to true so it respects the HBoxContainer size
		heart.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		heart.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		heart.custom_minimum_size = Vector2(5,5)
		add_child(heart)

func _on_player_hit(current_health: int):
	_draw_hearts(current_health)

func _on_player_spawn(_player):
	_draw_hearts(max_health)

func _draw_hearts(current_health: int):
	var hearts = get_children()
	for i in range(hearts.size()):
		if i < current_health:
			hearts[i].texture = RED_HEART
		else:
			hearts[i].texture = GREY_HEART
