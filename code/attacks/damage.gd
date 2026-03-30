class_name Damage extends Resource


enum Type {
	PHYSICAL = 0,
	ENERGY = 1
	}


@export var value := 0
@export var types:Array[Type] = [Type.PHYSICAL]


func _init(new_value:= 1, new_types := [Type.PHYSICAL]) -> void:
	value = new_value
	types = new_types
