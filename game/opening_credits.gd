extends Node
class_name OpeningCredits

@onready var order: Array = [$Items/Snakeob, $Items/Credits]
var index: int = 0
var item_length: float = 2.0
var item_timer: Timer

@export var next_scene: PackedScene

func _ready():
	$Fader.actor = self
	
	for node in $Items.get_children():
		if "modulate" in node:
			node.modulate = Color.BLACK
	
	item_timer = Timer.new()
	item_timer.one_shot = true
	add_child(item_timer)
	
	item_timer.timeout.connect(_on_hold_timeout)
	$Fader.fade_in_finished.connect(_on_fade_in_finished)
	$Fader.fade_out_finished.connect(_on_fade_out_finished)
	
	show_next_item()

func show_next_item():
	if index >= order.size():
		SceneLoader._next_scene(next_scene)
		return
		
	for node in $Items.get_children():
		if node != $Items/BlackScreen:
			node.visible = false
		
	var current_node = order[index]
	current_node.visible = true
	
	$Fader.fade_in() 
	index += 1

func _on_fade_in_finished():
	item_timer.start(item_length)

func _on_hold_timeout():
	$Fader.fade_out()

func _on_fade_out_finished():
	show_next_item()
