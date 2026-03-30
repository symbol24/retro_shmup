class_name GameplayScene extends Node2D


var _spawn_manager:SpawnManager = null
var _star_manager:StarManager = null


func _init() -> void:
	process_mode = PROCESS_MODE_PAUSABLE
	add_to_group(&"level")


func _ready() -> void:
	name = &"level"
	Signals.toggle_display.connect(_loading_complete_check)
	Signals.toggle_display.emit(&"play_ui", true)
	_spawn_manager = SpawnManager.new()
	add_child(_spawn_manager)
	if not _spawn_manager.is_node_ready(): await _spawn_manager.ready
	_star_manager = StarManager.new()
	add_child(_star_manager)
	_star_manager.name = &"star_manager"
	if not _star_manager.is_node_ready(): await _star_manager.ready
	Signals.spawn_player.emit()


func _loading_complete_check(_id:StringName, value:bool) -> void:
	if _id == &"loading_screen" and not value:
		print("Level plays intro here")
		Signals.activate_player_ship.emit(true)
