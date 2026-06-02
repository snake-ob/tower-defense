extends Node2D
class_name Rune

@export_file("*.tscn") var GemScene: String

func eject():
	if GemScene == "":
		return
		
	var gem_scene = load(GemScene)
	var new_gem = gem_scene.instantiate()
	new_gem.disable_slotting()
	
	new_gem.global_position = global_position
	SignalBus.spawned.emit(new_gem)
	queue_free()
