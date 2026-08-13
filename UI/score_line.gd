extends HBoxContainer
class_name ScoreLine

@export var event: String:
	set(val):
		$Thing.text = val
@export var score: int:
	set(val):
		$Score.text = str(val)
