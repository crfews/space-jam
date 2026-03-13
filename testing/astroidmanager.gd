extends Node3D

@export var asteroid_scene: PackedScene
@export var asteroid_count: int = 60
@export var move_speed: float = 15.0
@export var recycle_y: float = 5.0

@export var spawn_width_x: float = 8.0
@export var spawn_width_z: float = 8.0

@export var min_gap_y: float = 4.0
@export var max_gap_y: float = 8.0

var rng := RandomNumberGenerator.new()
var asteroids = []

func _ready() -> void:
	rng.randomize()

	var start_y = -20.0

	for i in range(asteroid_count):
		var asteroid = asteroid_scene.instantiate()
		add_child(asteroid)

		asteroid.position.x = rng.randf_range(-8.0, 8.0)
		asteroid.position.y = start_y
		asteroid.position.z = rng.randf_range(-8.0, 8.0)

		start_y -= rng.randf_range(8.0, 14.0)

		asteroids.append(asteroid)

func _process(delta: float) -> void:
	for asteroid in asteroids:
		asteroid.position.y += move_speed * delta

		if asteroid.position.y > recycle_y:
			asteroid.position.x = rng.randf_range(-8.0, 8.0)
			asteroid.position.y = -200.0
			asteroid.position.z = rng.randf_range(-8.0, 8.0)
