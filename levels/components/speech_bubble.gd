@tool
extends PanelContainer
class_name SpeechBubble

var active: bool = false
var king: King

func _setup_lvl(p_ref):
	king = p_ref.king

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

func set_bubble_text(new_text: String):
	var label = get_child(0) as Label
	if label:
		label.text = new_text
		update_bubble()
