extends CanvasLayer

@onready var speed_label = $VBoxContainer/SpeedLabel
@onready var lap_label = $VBoxContainer/LapLabel
@onready var timer_label = $VBoxContainer/TimerLabel
@onready var speed_bar = $VBoxContainer/SpeedBar
@onready var position_label = $VBoxContainer/PositionLabel
@onready var boost_bar = $VBoxContainer/BoostBar

var player: CharacterBody3D
var elapsed_time: float = 0.0
var current_lap: int = 1
var max_laps: int = 3
var race_started: bool = false

func _ready() -> void:
	player = get_tree().root.get_child(0).find_child("Player", true, false)
	if not player:
		player = get_parent().find_child("Player", true, false)

	# Start race when scene loads
	if player:
		start_race()

func _process(delta: float) -> void:
	if player and race_started:
		elapsed_time += delta
		
		# Update speed display
		var speed = abs(player.current_speed)
		speed_label.text = "Speed: %.0f km/h" % speed
		speed_bar.value = player.get_speed_percentage() * 100
		
		# Update boost bar
		if player.is_boosting:
			boost_bar.value = (player.boost_duration / 1.0) * 100
		else:
			boost_bar.value = 0
		
		# Update lap and timer
		lap_label.text = "Lap: %d / %d" % [current_lap, max_laps]
		timer_label.text = "Time: %s" % format_time(elapsed_time)
		
		# Update position
		position_label.text = "Pos: (%.1f, %.1f, %.1f)" % [
			player.global_position.x,
			player.global_position.y,
			player.global_position.z
		]

func format_time(seconds: float) -> String:
	var mins = int(seconds) / 60
	var secs = int(seconds) % 60
	var ms = int((seconds - int(seconds)) * 100)
	return "%02d:%02d.%02d" % [mins, secs, ms]

func start_race() -> void:
	race_started = true
	elapsed_time = 0.0

func finish_race() -> void:
	race_started = false
	var final_time = format_time(elapsed_time)
	print("Race finished! Final time: ", final_time)

func next_lap() -> void:
	current_lap += 1
	if current_lap > max_laps:
		finish_race()