class_name NormalMove extends BaseAction


func _process(delta: float) -> void:
	if _ship and _ship.data:
		var direction := Input.get_vector("left", "right", "up", "down")
		_ship.set_new_velocity(move(delta, direction), direction)


func move(delta:float, direction:Vector2) -> Vector2:
	direction.clampf(-0.7, 0.7)

	var x := _ship.velocity.x
	var y := _ship.velocity.y
	if direction == Vector2.ZERO:
		x = move_toward(x, 0, delta * _ship.data.friction)
		y = move_toward(y, 0, delta * _ship.data.friction)
	else:
		x = move_toward(x, direction.x * _ship.data.speed, delta * _ship.data.acceleration)
		y = move_toward(y, direction.y * _ship.data.speed, delta * _ship.data.acceleration)


	return Vector2(x, y)
