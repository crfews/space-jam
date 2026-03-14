extends Node3D

@export var asteroid_scene: PackedScene
@export var player : Node3D
@export var num_asteroids := 500
@export var field_radius := 100.0
@export var asteroid_speed := 50.0
@export var n_layers := 5
@export var layer_spacing := 20.0
@export var remove_y := 50.0
@export var GameManager : Node3D
@export var wireframe_shader : ShaderMaterial

var score := 0
var _rendered_slices: Array[Node3D] = []

func _ready() -> void:
	randomize()

	# Build all slices once
	for i in range(n_layers):
		var slice := create_slice()
		slice.position.y = -i * layer_spacing
		add_child(slice)
		_rendered_slices.append(slice)

func set_asteroid_color(color: Color) -> void:
	var mat := wireframe_shader as ShaderMaterial
	if mat:
		mat.set_shader_parameter("asteroid_color", color)

func _process(delta: float) -> void:

	# Get timer from GameManager
	score = GameManager.score # Assuming timer has a time_left property
	if score > 60:
		asteroid_speed = score * 1.5
		set_asteroid_color(Color(1.0, 0.0, 0.0)) # Red
	elif score > 40:
		asteroid_speed = 90.0
		set_asteroid_color(Color(1.0, 0.5, 0.0)) # Orange
	elif score > 20:
		asteroid_speed = 70.0
		set_asteroid_color(Color(1.0, 1.0, 0.0)) # Yellow

	# Move whole slices, not individual asteroids
	for slice in _rendered_slices:
		slice.position.y += asteroid_speed * delta

	if _rendered_slices.is_empty():
		return

	var front_slice := _rendered_slices[0]

	# Recycle front slice to the back
	if front_slice.position.y > remove_y:
		_rendered_slices.pop_front()

		var back_y := get_backmost_y()

		front_slice.position.y = back_y - layer_spacing
		front_slice.position.x = player.position.x  # Keep slices centered on player
		front_slice.position.z = player.position.z
		randomize_slice(front_slice)

		_rendered_slices.append(front_slice)


func create_slice() -> Node3D:
	var slice := Node3D.new()

	for i in range(num_asteroids):
		var asteroid := asteroid_scene.instantiate() as Area3D
		var mesh := asteroid.get_node("MeshInstance3D") as MeshInstance3D
		if mesh:
			mesh.material_override = wireframe_shader

		slice.add_child(asteroid)

	randomize_slice(slice)
	return slice


func randomize_slice(slice: Node3D) -> void:
	for asteroid in slice.get_children():
		var angle := randf() * TAU
		var distance := sqrt(randf()) * field_radius

		asteroid.position = Vector3(
			cos(angle) * distance,
			0.0,
			sin(angle) * distance
		)

		asteroid.rotation = Vector3(
			randf_range(0.0, TAU),
			randf_range(0.0, TAU),
			randf_range(0.0, TAU)
		)

		asteroid.scale = Vector3.ONE * randf_range(0.7, 1.4)


func get_backmost_y() -> float:
	var min_y := _rendered_slices[0].position.y

	for slice in _rendered_slices:
		if slice.position.y < min_y:
			min_y = slice.position.y

	return min_y
