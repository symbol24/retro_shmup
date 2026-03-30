class_name HitBox extends Area2D


var _hitbox_owner:BaseShip = null
var _damage:Damage = null


func setup_hitbox(new_owner:BaseShip, damage_value := 1, damage_types := [Damage.Type.PHYSICAL]) -> void:
	_hitbox_owner = new_owner
	_damage = Damage.new(damage_value, damage_types)


func get_damage() -> Damage:
	return _damage
