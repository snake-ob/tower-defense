extends Resource
class_name InvData

@export var item_name: String
@export var unlocked: bool = false
@export var max: int = 0
@export var current: int = 0:
	set(val):
		SignalBus.inv_updated.emit()
