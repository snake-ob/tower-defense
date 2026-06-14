extends Area2D

var slots: Array = [null, null]

func _ready():
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)
	if not body_exited.is_connected(_on_body_exited):
		body_exited.connect(_on_body_exited)
		
	slots.resize(2)

func _on_body_entered(body):
	body.transfer_gem(self)

func _on_body_exited(body):
	pass

func slot_rune(p_rune):
	add_child(p_rune)
	if slots[1] != null:
		slots[1].eject()
	if slots[0] != null:
		slots[1] = slots[0]
		slots[1].position = $PosTwo.position
		
	slots[0] = p_rune
	slots[0].position = $PosOne.position
