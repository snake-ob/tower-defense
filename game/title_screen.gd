extends Node2D


func _ready():
	GameData.reset_towers()
	Inventory._reset_items()
	var title_song = load("res://audio/trax/Menu.mp3")
	Sound.play_music(title_song, true)
