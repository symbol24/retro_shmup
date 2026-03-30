class_name PlayerShip extends BaseShip


func _ready() -> void:
	super()
	Signals.activate_player_ship.connect(_activate)
