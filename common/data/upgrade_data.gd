extends Resource
class_name UpgradeData

@export var upgrade: String
@export var title: String
@export var path: String
@export var cost: int
@export var description: String
@export var icon: Texture2D
@export_range(1, 100) var chance: int = 100
