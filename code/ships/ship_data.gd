class_name ShipData extends Resource


@export var id := &""
@export var uid := ""

# Movement
@export var _base_speed := 100.0
@export var acceleration := 500.0
@export var friction := 200.0

# Weapons
@export var weapons:Array[WeaponData]


var speed := _base_speed
