extends Area2D

signal king_taken()

func _ready():
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)
		
func _on_body_entered(body):
	if body is King:
		king_taken.emit()
