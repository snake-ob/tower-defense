extends Node

var soundConsoleScene = preload("res://SoundConsole.tscn")

var soundConsole : SoundConsole

var speaker : String

var voices = {
	"text_bloop" : preload("res://text-blip.wav"),
	"ghostcat" : preload("res://ghostcat-voice.wav"),
}

func _ready():
	soundConsole = soundConsoleScene.instantiate()
	add_child(soundConsole)
	speaker = ""

func play_sfx(sound):
	soundConsole.play_SFX(sound)

func play_music(sound):
	soundConsole.play_music(sound)

func play_text_sound():
	if speaker == "":
		soundConsole.play_textAudio(voices["text_bloop"])
	else:
		random_voice_sound(voices[speaker])

func set_speaker(new_speaker):
	speaker = new_speaker

func random_voice_sound(stream):
	var stream_length = stream.get_length()
	var target_length = 0.25
	var cursor = randf_range(0.0, stream_length)
	var end_position = cursor + target_length
	end_position = clamp(end_position, 0.0, stream_length)
	
	soundConsole.play_voice(stream, cursor, end_position)
	
