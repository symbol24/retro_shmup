class_name MovingStar extends Sprite2D


const COLORS:Array[Color] = [Color.AZURE, Color.ALICE_BLUE, Color.AQUAMARINE, Color.BISQUE, Color.MISTY_ROSE, Color.LIGHT_BLUE, Color.AQUA, Color.HOT_PINK]
const SPEEDS := [25.0, 12.5, 6.25]
const SUPERMULTI := 15.0


var _layer := 1
var _speed := 100.0
var _speed_multi := 1.0
var _active := false
var _original_offset_y := 0.0


func _ready() -> void:
	Signals.activate_stars.connect(_activate)


func _physics_process(delta: float) -> void:
	if _active:
		_move(delta)


func setup_star(new_layer := 1, _offset := 0.0) -> void:
	_reset_color()
	_layer = new_layer
	_reset_speed()
	_original_offset_y = _offset
	#scale *= 0.5


func _move(_delta:float) -> void:
	global_position.y = move_toward(global_position.y, global_position.y + 1, _delta * _speed)
	if global_position.y > GameManager.VERMAX[1]:
		_reset_color()
		global_position.y = global_position.y - GameManager.VERMAX[1]


func _activate(_is_active := false) -> void:
	_active = _is_active


func _reset_color() -> void:
	modulate = COLORS[0] if randf() <= 0.5 else COLORS[randi_range(1, COLORS.size()-1)]


func _super_speed() -> void:
	_speed_multi = SUPERMULTI
	scale.y = SUPERMULTI


func _reset_speed() -> void:
	_speed = SPEEDS[_layer-1]
	_speed_multi = 1.0
	scale = Vector2(0.5, 0.5)
