class_name Projectile extends HitBox


var _data:ProjectileData = null
var _speed := 200.0
var _direction := Vector2.UP
var _is_active := false


func _process(delta: float) -> void:
	if _is_active: 
		_move_projectile(delta)


func setup_hitbox(new_owner:BaseShip, damage_value := 1, damage_types := [Damage.Type.PHYSICAL], speed = 200.0, direction := Vector2.UP, data:ProjectileData = null) -> void:
	super(new_owner, damage_value, damage_types)
	_speed = speed
	_direction = direction
	_data = data
	name = data.id


func shoot() -> void:
	_is_active = true


func destroy() -> void:
	_is_active = false
	Signals.return_projectile.emit(self)


func get_data() -> ProjectileData:
	return _data


func _move_projectile(delta:float) -> void:
	position.y  = move_toward(position.y, position.y + _direction.y, delta * _speed)
	if global_position.y > GameManager.VERMAX[1] or global_position.y < GameManager.VERMAX[0]: destroy()
