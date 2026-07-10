extends Node2D

@onready var sprite = $AnimatedSprite2D

func _ready():	
	sprite.play('explode')
	sprite.animation_finished.connect(_on_anim_finished)
	
func _on_anim_finished():
	if sprite.animation == "explode":
		queue_free()
