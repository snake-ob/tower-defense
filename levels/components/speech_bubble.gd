@tool
extends PanelContainer
class_name SpeechBubble

@export var active: bool = false
var king: King
var speech_timer: Timer
var speech_timing: float = 4.0

func _setup_lvl(p_ref):
	king = p_ref.king

func _ready():
	speech_timer = Timer.new()
	speech_timer.one_shot = true
	speech_timer.timeout.connect(_on_speech_timeout)
	add_child(speech_timer)

func _physics_process(delta):
	if not active:
		visible = false
		return
	visible = true
	if king:
		global_position = king.get_sprite_pos()
		global_position.x += 4
		global_position.y -= size.y + 4 # Offset the size of speech bubble + king

func update_bubble():
	custom_minimum_size = Vector2.ZERO
	update_minimum_size()
	
func set_bubble(_diag: DiagData):
	var speech_length: float = set_bubble_text(_diag.text)
	set_bubble_graphic(_diag.graphic)
	active = true
	speech_timer.start(speech_length)

func set_bubble_text(new_text: String) -> float:
	var label = get_child(0) as Label
	if label:
		label.text = new_text
		update_bubble()
		
	var punctuation: String = ".,!?;:\"'()[]{}- "
	var pause_chars: float = 1.0
	for char in new_text:
		if char in punctuation:
			pause_chars += 0.35
	return pause_chars

func set_bubble_graphic(_graphic: String):
	if _graphic == "":
		$Control.visible = false
		return
	$Control.visible = true
	$Control/AnimatedSprite2D.play(_graphic)
	
func _on_speech_timeout():
	active = false
