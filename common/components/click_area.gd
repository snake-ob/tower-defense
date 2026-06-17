extends Area2D

signal clicked(caller)
var actor: Node2D

func _setup(p_ref):
	actor = p_ref.actor
