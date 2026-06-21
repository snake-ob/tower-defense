extends Node
class_name StatusUpgrade

@export var status: PackedScene
@export var upgrade: TowerUpgrade
var unique_id: int

func _get_status():
	return status

func _get_upgrade():
	return upgrade
