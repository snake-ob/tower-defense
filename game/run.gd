extends Node
class_name Run

var start_scene = preload("res://game/OpeningCredits.tscn")

func _ready():
	SceneLoader._next_scene(start_scene)
