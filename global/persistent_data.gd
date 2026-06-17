extends Node
class_name PersistentData

var towers: Array[Dictionary] = [
	{
		'runes': ['res://entities/tower/runes/Rune.tscn', 'res://entities/tower/runes/Rune.tscn'],
		'id': 0
	}
]

func reset_towers():
	towers = [
		{
			'runes': [],
			'id': 0
		}
		]
