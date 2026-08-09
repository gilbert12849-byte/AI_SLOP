extends Node3D

@export var follow_distance: float = 6.0
@export var follow_height: float = 3.0
@export var camera_speed: float = 5.0
@export var look_ahead_distance: float = 2.0

@onready var camera_3d = $Camera3D
@onready var player = get_parent()

var target_position: Vector3
var target_lookat: Vector3

func _ready() -> void:
	target_position = global_position
	target_lookat = player.global_position

func _process(delta: float) -> void:
	if not player:
		return
	
	# Get player forward direction
	var player_forward = -player.global_transform.basis.z
	var player_up = player.global_transform.basis.y
	
	# Calculate target position
	target_position = player.global_position - player_forward * follow_distance + player_up * follow_height
	
	# Look ahead point
	target_lookat = player.global_position + player_forward * look_ahead_distance
	
	# Smoothly move camera
	global_position = global_position.lerp(target_position, camera_speed * delta)
	
	# Look at target
	look_at(target_lookat, player_up)