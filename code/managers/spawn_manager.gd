class_name SpawnManager extends Node


const DEBUGPLAYER := preload("uid://beexh7o4k0xpj")


var _save:SaveManager = null:
	get:
		if _save == null: _save = get_tree().get_first_node_in_group(&"save_manager")
		return _save
var _level:GameplayScene = null:
	get:
		if _level == null: _level = get_tree().get_first_node_in_group(&"level")
		return _level
var ship:PlayerShip = null


func _init() -> void:
	add_to_group(&"spawn_manager")
	name = &"spawn_manager"
	process_mode = PROCESS_MODE_PAUSABLE


func _ready() -> void:
	Signals.spawn_player.connect(_spawn_player)


func _spawn_player() -> void:
	var to_spawn:PlayerShipData = DEBUGPLAYER
	if _save.loaded_save_file.current_ship != null: to_spawn = _save.loaded_save_file.current_ship
	ship = load(to_spawn.uid).instantiate()
	_level.add_child(ship)
	ship.setup_ship(to_spawn, Vector2(240, 180))
