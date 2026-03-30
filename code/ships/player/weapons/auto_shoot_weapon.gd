class_name AutoShootWeapon extends WeaponPlatform


var _cycling := false


func _process(_delta: float) -> void:
	if _ship.is_active and not _cycling:
		_bullet_shoot_cycle()


func _bullet_shoot_cycle() -> void:
	if _ship.is_active:
		_cycling = true
		if not _shooting:
			await get_tree().create_timer(_weapon_data.burst_delay).timeout
			_shooting = true
			_bullet_shoot_cycle()

		else: 
			await _shoot_burst()
			_shooting = false
			_bullet_shoot_cycle()
