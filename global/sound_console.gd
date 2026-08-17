extends Node

@onready var SFX = $SFX
@onready var Music = $Music/Channel1

func _ready():
	for channel in SFX.get_children():
		if channel is AudioStreamPlayer:
			channel.finished.connect(_on_stream_finished.bind(channel))

func play_SFX(sfx):
	for channel in SFX.get_children():
		if not channel.is_playing():
			channel.set_stream(sfx)
			channel.pitch_scale = randf_range(0.900, 1.050)
			channel.play()
			break
	
func play_music(track, _loop):
	if track != null:
		Music.set_stream(track)
		Music.play()
	else:
		Music.set_stream(null)
	
	Music.stream.loop = _loop

func play_iso_SFX(sfx, _channel):
	var channel = $SFX.get_child(_channel)
	channel.set_stream(sfx)
	channel.pitch_scale = randf_range(0.900, 1.050)
	channel.play()
	
func stop_music():
	Music.stop()
	
func _on_stream_finished(channel : AudioStreamPlayer):
	channel.set_stream(null)
