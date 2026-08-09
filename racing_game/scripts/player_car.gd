extends CharacterBody3D

# Movement properties
@export var max_speed: float = 50.0
@export var acceleration: float = 30.0
@export var friction: float = 8.0
@export var turn_speed: float = 3.5
@export var turn_friction: float = 5.0
@export var tilt_angle: float = 0.35
@export var gravity: float = 9.8

# State variables
var current_speed: float = 0.0
var is_boosting: bool = false
var boost_duration: float = 0.0
var boost_speed: float = 80.0
var base_max_speed: float = 50.0

# Inputs
var input_acceleration: float = 0.0
var input_turn: float = 0.0

# References
@onready var model = $Model if has_node("Model") else null
@onready var camera_mount = $CameraMount if has_node("CameraMount") else null

func _physics_process(delta: float) -> void:
	# Get input
	input_turn = Input.get_axis("ui_left", "ui_right")
	input_acceleration = Input.get_axis("ui_down", "ui_up")
	
	# Handle boost
	if Input.is_action_just_pressed("ui_accept"):
		start_boost()
	
	if is_boosting:
		boost_duration -= delta
		if boost_duration <= 0:
			is_boosting = false
			base_max_speed = 50.0
	
	# Calculate target speed
	var target_speed = max_speed * input_acceleration
	
	# Apply acceleration/friction
	current_speed = move_toward(current_speed, target_speed, acceleration * delta)
	
	# Handle turning
	if input_turn != 0:
		rotate_y(-input_turn * turn_speed * delta)
		if model:
			model.rotation.z = lerp(model.rotation.z, -input_turn * tilt_angle, delta * turn_friction)
	else:
		if model:
			model.rotation.z = lerp(model.rotation.z, 0.0, delta * turn_friction)
	
	# Calculate velocity based on forward direction
	var forward = -global_transform.basis.z
	velocity = forward * current_speed
	
	# Apply gravity
	velocity.y -= gravity * delta
	
	# Move and slide
	move_and_slide()

func start_boost() -> void:
	if not is_boosting and current_speed > 5.0:
		is_boosting = true
		boost_duration = 1.0
		base_max_speed = 80.0
		max_speed = boost_speed

func get_speed_percentage() -> float:
	return min(abs(current_speed) / boost_speed, 1.0)

func get_is_moving() -> bool:
	return abs(current_speed) > 0.5

func reset_position(new_position: Vector3) -> void:
	global_position = new_position
	velocity = Vector3.ZERO
	current_speed = 0.0
	is_boosting = false
	boost_duration = 0.0
	base_max_speed = 50.0