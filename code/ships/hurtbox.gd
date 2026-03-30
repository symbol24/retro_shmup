class_name HurtBox extends Area2D


var parent:BaseShip = null:
	get:
		if parent == null: parent = get_parent() as BaseShip
		return parent




func _area_entered(_area:Area2D) -> void:
	pass
