# Godot Kart Racer

A simple kart racing game built with Godot 4.1

## Features

- **Kart Controller**: Smooth acceleration, deceleration, and turning mechanics
- **Camera System**: Third-person follow camera that tracks the kart
- **Speed Boost**: Press SPACE to temporarily boost your kart's speed
- **Race UI**: Real-time speed display, lap counter, and timer
- **Dynamic Kart Tilt**: The kart tilts when turning for visual feedback
- **Simple Track**: Basic track with walls and boundaries

## Controls

| Input | Action |
|-------|--------|
| **Arrow Keys** or **WASD** | Move kart |
| **SPACE** | Boost |
| **ESC** | Exit |

## How to Run

1. Open this project in Godot 4.1+
2. Press **Play** or F5 to start the game
3. Use the controls to drive around the track

## Project Structure

```
kart_game/
├── scenes/
│   └── main.tscn           # Main game scene with kart and track
├── scripts/
│   ├── kart_controller.gd  # Kart movement and physics
│   ├── camera_controller.gd # Third-person camera
│   ├── race_ui.gd          # UI display (speed, lap, timer)
│   └── track_collider.gd   # Track and collision management
├── project.godot           # Project configuration
└── README.md               # This file
```

## Customization

You can easily customize the game by modifying these export variables:

### Kart Controller (`scripts/kart_controller.gd`)
- `max_speed`: Maximum kart speed (default: 50.0)
- `acceleration`: How quickly the kart speeds up (default: 20.0)
- `friction`: How quickly the kart slows down (default: 5.0)
- `turn_speed`: Rotation speed when turning (default: 3.0)
- `tilt_angle`: How much the kart tilts when turning (default: 0.3)

### Camera Controller (`scripts/camera_controller.gd`)
- `follow_distance`: Distance behind the kart (default: 5.0)
- `follow_height`: Height above the kart (default: 2.0)
- `camera_speed`: Smoothness of camera movement (default: 5.0)

## Future Enhancements

- [ ] Multiple laps and lap tracking
- [ ] AI opponent karts
- [ ] Drifting mechanics
- [ ] Power-ups and items
- [ ] Multiple tracks
- [ ] Multiplayer support
- [ ] Improved graphics and animations
- [ ] Sound effects and music
- [ ] Best lap/time tracking

## License

Free to use and modify!
