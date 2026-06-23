extends Node2D
class_name PurchaseScreen

var red_font = Color.html('#ff451f')
var opaque = Color(0,0,0,0)

@onready var item: Sprite2D = $Item
@onready var name_label: Label = $Name
@onready var desc: Label = $Desc
@onready var cost: Label = $Cost

func _ready():
	cost.label_settings.outline_color = opaque

func set_shop(p_data: UpgradeData):
	item.texture = p_data.icon
	name_label.text = p_data.title
	desc.text = p_data.description
	cost.text = str(p_data.cost)
	
func insufficient_funds():
	var stored_pos = cost.position
	var stored_font = cost.label_settings.font_color
	var stored_shadow = cost.label_settings.shadow_color
	var stored_outline = cost.label_settings.outline_color
	cost.label_settings.font_color = red_font
	cost.label_settings.shadow_color = opaque
	cost.label_settings.outline_color = Color(1,1,1,1)
	for i in range(4):
		if cost.position == stored_pos:
			cost.position = stored_pos + Vector2(1,0)
		else:
			cost.position = stored_pos
		await get_tree().create_timer(0.1).timeout
	cost.position = stored_pos
	cost.label_settings.font_color = stored_font
	cost.label_settings.shadow_color = stored_shadow
	cost.label_settings.outline_color = stored_outline
