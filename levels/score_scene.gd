extends Node2D

@onready var anim_player: AnimationPlayer = $AnimationPlayer

var _waiting_for_click: bool = false

func _ready() -> void:
	GlobalClick.is_enabled = false # turn off click logic
	anim_player.animation_finished.connect(_on_animation_finished)
	play_sequence()
	if SceneLoader.current_scene == null:
		SceneLoader.current_scene = self
	var score_song = load("res://audio/trax/Score.mp3")
	Sound.play_music(score_song, true)

func play_sequence() -> void:
	anim_player.play("fade_in")
	anim_player.queue("enter")
	anim_player.queue("fallback")
	anim_player.queue("scroll_drop")

func _unhandled_input(event: InputEvent) -> void:
	if _waiting_for_click and event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			_waiting_for_click = false
			_play_remaining_sequence()

func _play_remaining_sequence() -> void:
	anim_player.play("scroll_lift")
	anim_player.queue("fall_out")
	anim_player.queue("fade_out")

func _on_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"scroll_drop":
			_waiting_for_click = true
			
		"fade_out":
			_on_sequence_completed()

func _on_sequence_completed() -> void:
	var menu_scene: PackedScene = load("res://game/TitleScreen.tscn")
	SceneLoader._next_scene(menu_scene)
