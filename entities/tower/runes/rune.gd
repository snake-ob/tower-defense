extends Node2D
class_name Rune

@export_file("*.tscn") var GemScene: String
@export_file("*.tscn") var upgrade: String
var unique_id: int

func _ready():
	unique_id = ResourceUID.create_id()

func eject():
	if GemScene == "":
		return
		
	var gem_scene = load(GemScene)
	var new_gem = gem_scene.instantiate()
	new_gem.disable_slotting()
	
	new_gem.global_position = global_position
	SignalBus.spawned.emit(new_gem)
	queue_free()
