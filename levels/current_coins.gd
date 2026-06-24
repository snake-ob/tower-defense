extends Label

var target_money: int = 0
var displayed_money: float = 0.0

var money_tween: Tween

func _ready() -> void:
	text = str(Inventory.wallet)
	pivot_offset = size / 2.0
	Inventory.coin_added.connect(_on_coin_collected)

func _process(delta: float) -> void:
	if displayed_money != target_money:
		displayed_money = move_toward(displayed_money, target_money, 3.0 * delta)

		text = str(round(displayed_money))

func _on_coin_collected():
	update_money(Inventory.wallet)

func update_money(amount: int) -> void:
	target_money = amount
	jiggle()

func jiggle() -> void:
	if money_tween and money_tween.is_valid():
		money_tween.kill()
		
	money_tween = create_tween()
	
	money_tween.parallel().tween_property(self, "scale", Vector2(1.3, 1.3), 0.05)
	money_tween.parallel().tween_property(self, "rotation_degrees", randf_range(-5.0, 5.0), 0.05)
	
	money_tween.parallel().tween_property(self, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	money_tween.parallel().tween_property(self, "rotation_degrees", 0.0, 0.15)
