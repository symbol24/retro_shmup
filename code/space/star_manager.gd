class_name StarManager extends Node2D


const ONEONE := preload("uid://btefskoflb717")
const TWOTWO := preload("uid://b5v46alvq15kj")


var _active_stars:Array[MovingStar] = []
var _oneone:MovingStar = null:
	get:
		if _oneone == null: _oneone = ONEONE.instantiate()
		return _oneone
var _twotwo:MovingStar = null:
	get:
		if _twotwo == null: _twotwo = TWOTWO.instantiate()
		return _twotwo


func _ready() -> void:
	_spawn_stars(24, 3)


func _spawn_stars(offset := 12.0, layers := 3) -> void:
	var x_count := (GameManager.HORMAX[1] - GameManager.HORMAX[0]) / offset
	var y_count := (GameManager.VERMAX[1] - GameManager.VERMAX[0]) / offset
	var half := offset/2

	for x in x_count:
		for y in y_count:
			var y_offset := randf_range(-half, half)
			var pos := Vector2((x * offset) + ((x+1) * half) + randf_range(-half, half), (y * offset) + ((y+1) * half) + y_offset)
			var new_star:MovingStar = _oneone.duplicate() if randf() >= 0.1 else _twotwo.duplicate()
			add_child(new_star)
			new_star.name = &"star_"
			new_star.global_position = pos
			var l := randi_range(1, layers)
			new_star.setup_star(l, y_offset)
			_active_stars.append(new_star)
	
	Signals.activate_stars.emit(true)
