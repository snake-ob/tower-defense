# Ref.gd
extends Node
class_name Ref

var data: Dictionary = {}

func _set(property: StringName, value: Variant) -> bool:
	data[property] = value
	return true

func _get(property: StringName) -> Variant:
	return data.get(property, null)

func has(property: StringName) -> bool:
	return data.has(property)
