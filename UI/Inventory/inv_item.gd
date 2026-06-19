extends Node2D
class_name InvSlot

var unavailable_color = Color(1, 1, 1, 0.3)
var inv_manager: InventoryManager

func _ready():
	_enable_scroll(true)

func _setup_lvl(p_ref):
	inv_manager = p_ref.inv_manager

func set_item_ui(p_texture):
	if p_texture:
		$Item.texture = p_texture
		$Item.visible = true
	else:
		$Item.texture = null
		$Item.visible = false

func set_modulation(a: bool):
	if a:
		$Item.modulate = unavailable_color
	else:
		$Item.modulate = Color.WHITE

func _clicked(vp, event, shape_idx):
	if not event is InputEventMouseButton or event.pressed:
		return
	elif event.button_index == MOUSE_BUTTON_LEFT:
		inv_manager.item_clicked()

func _enable_scroll(option: bool):
	$ScrollLeft.visible = option
	$ScrollRight.visible = option
	$ScrollLeft/Area2D.input_pickable = option
	$ScrollRight/Area2D.input_pickable = option

func _on_scroll(vp: Node, event: InputEvent, shape_idx: int, dir: int) -> void:
	if not event is InputEventMouseButton or event.pressed:
		return
	elif event.button_index == MOUSE_BUTTON_LEFT:
		inv_manager._change_slot(dir)

func _update_label(p_label: int) -> void:
	var label: String = str(p_label)
	if p_label:
		$Label.text = label
	else:
		$Label.text = "0"
