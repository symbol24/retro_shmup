class_name WeaponPlatform extends BaseAction


@export var points:Array[Marker2D] = []

var _weapon_data:WeaponData = null
var _level:GameplayScene = null:
	get:
		if _level == null: _level = get_tree().get_first_node_in_group(&"level")
		return _level

# Firing sequence
var _shooting := false
var _bullet_scene:PackedScene = null
var _pool:Array[Projectile] = []


func _ready() -> void:
	super()
	Signals.return_projectile.connect(_return_projectile)


func setup_weapon(new_data:WeaponData) -> void:
	_weapon_data = new_data
	if _weapon_data.id != &"": name = _weapon_data.id
	assert(not points.is_empty(), name + " does not have any firing points. Fixit!")
	assert(points.size() == _weapon_data.expected_firing_points, name + " does not have the right amount of firing points setup.")
	_bullet_scene = load(_weapon_data.projectile_data.uid)
	_shooting = true


func _bullet_shoot_cycle() -> void:
	if _ship.is_active:
		if not _shooting:
			await get_tree().create_timer(_weapon_data.burst_delay).timeout
			_shooting = true
			_bullet_shoot_cycle()

		else: 
			await _shoot_burst()
			_shooting = false
			_bullet_shoot_cycle()


func _shoot_burst() -> void:
	for count in _weapon_data.bullets_per_burst:
		for each in points:
			_shoot_one(each.global_position, each.rotation)
		if _weapon_data.delay_between_bullets > 0.0:
			await get_tree().create_timer(_weapon_data.delay_between_bullets).timeout


func _shoot_one(pos:Vector2, rot:float) -> void:
	_shooting = true
	var projectile:Projectile = _get_bullet()
	assert(projectile is Projectile)
	_level.add_child(projectile)
	if not projectile.is_node_ready(): await projectile.ready
	projectile.global_position = pos
	projectile.rotation = rot
	projectile.setup_hitbox(_ship, _weapon_data.projectile_data.damage, _weapon_data.projectile_data.types, _weapon_data.projectile_data.speed, Vector2.UP, _weapon_data.projectile_data)
	projectile.shoot()
	_shooting = false


func _get_bullet() -> Projectile:
	if _pool.is_empty():
		return _bullet_scene.instantiate()
	return _pool.pop_front()


func _return_projectile(projectile:Projectile) -> void:
	if projectile.get_data() == _weapon_data.projectile_data:
		_level.remove_child(projectile)
		_pool.append(projectile)
