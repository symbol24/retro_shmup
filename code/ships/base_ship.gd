class_name BaseShip extends CharacterBody2D


@export var debug_data:ShipData

var data:ShipData
var is_active := false

# Movement
var _can_move := true
var _direction := Vector2.ZERO


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	if is_active and _can_move:
		move_and_slide()
		global_position.x = clamp(global_position.x, GameManager.HORMAX[0], GameManager.HORMAX[1])
		global_position.y = clamp(global_position.y, GameManager.VERMAX[0], GameManager.VERMAX[1])


func setup_ship(new_data:ShipData, new_pos:Vector2) -> void:
	if new_data != null: data = new_data.duplicate(true)
	else:
		assert(debug_data != null, name + " does not have debug data and is trying to use it.")
		data = debug_data.duplicate(true)
	global_position = new_pos
	for weapon in data.weapons:
		_setup_weapon(weapon)


func set_new_velocity(new_velocity := Vector2.ZERO, new_direction := Vector2.ZERO) -> void:
	velocity = new_velocity
	_direction = new_direction


func _setup_weapon(weapon_data:WeaponData) -> void:
	var new_platform:WeaponPlatform = load(weapon_data.uid).instantiate()
	add_child(new_platform)
	if not new_platform.is_node_ready(): await new_platform.ready
	new_platform.setup_weapon(weapon_data)


func _activate(value := false) -> void:
	is_active = value
	
