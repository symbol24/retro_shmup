class_name BaseAction extends Node2D


var _ship:BaseShip = null:
	get:
		if _ship == null: _ship = get_parent() as BaseShip
		return _ship


func _ready() -> void:
	pass
