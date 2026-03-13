extends Node3D

@export var asteroid_scene: PackedScene
@export var asteroid_count: int = 15
@export var move_speed: float = 15.0
@export var recycle_z: float = 5.0

var rng := RandomNumberGenerator.new()
var asteroids = []

func _ready() -> void:
	rng.randomize()

	var start_z = -20.0

	for i in range(asteroid_count):
		var asteroid = asteroid_scene.instantiate()
		add_child(asteroid)

		asteroid.position.x = rng.randf_range(-8.0, 8.0)
		asteroid.position.y = rng.randf_range(-8.0, 8.0)
		asteroid.position.z = start_z

		start_z -= rng.randf_range(8.0, 14.0)

		asteroids.append(asteroid)

func _process(delta: float) -> void:
	for asteroid in asteroids:
		asteroid.position.z += move_speed * delta

		if asteroid.position.z > recycle_z:
			asteroid.position.x = rng.randf_range(-8.0, 8.0)
			asteroid.position.y = rng.randf_range(-8.0, 8.0)
			asteroid.position.z = -200.0
