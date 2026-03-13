extends Node3D

@export var asteroid_scene: PackedScene
@export var num_asteroids := 50
@export var field_radius := 50.0
@export var asteroid_speed := 10.0
@export var n_layers := 5
@export var layer_spacing := 20.0

var _asteroid_slices = []

func generate_asteroid_slice() -> Array[MeshInstance3D]:
	# Generates a 2D slice of asteroids in the XZ plane.
	var asteroids: Array[MeshInstance3D] = []
	for i in range(num_asteroids):
		var asteroid_instance := asteroid_scene.instantiate() as MeshInstance3D
		var angle := randf() * TAU
		var distance := sqrt(randf()) * field_radius
		asteroid_instance.position = Vector3(cos(angle) * distance, 0, sin(angle) * distance)
		asteroids.append(asteroid_instance)
	return asteroids


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Generate n layers of asteroids with increasing distance from the camera

	for i in range(n_layers):
		var slice := generate_asteroid_slice()
		for asteroid in slice:
			asteroid.position.y = -i * layer_spacing
			add_child(asteroid)
		#_asteroid_slices.append(slice)
		_asteroid_slices.push_front(slice)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#move towards camera
	for asteroid in get_children():
		if asteroid is MeshInstance3D:
			asteroid.translate(Vector3(0, 10 * delta, 0))

	#remove asteroids that have passed the camera
	for asteroid in get_children():

		# Free individual 
		# if asteroid is MeshInstance3D and asteroid.position.y > 50:
		# 	asteroid.queue_free()

		# Free entire slice if any asteroid in it has passed the camera
		for slice in _asteroid_slices:
			if slice.size() > 0 and slice[0].position.y > 50:
				for a in slice:
					a.queue_free()
				_asteroid_slices.erase(slice)


	# If asteroid is removed, add a new one at the back of the field
	# if _asteroid_slices.size() < n_layers:
	# 	var slice := generate_asteroid_slice()
	# 	for asteroid in slice:
	# 		asteroid.position.y = -n_layers * layer_spacing
	# 		add_child(asteroid)
	# 	_asteroid_slices.append(slice)

	# If asteroid slice is removed, add a new one at the layer_spacing behind the last layer
	if _asteroid_slices.size() < n_layers:
		var slice := generate_asteroid_slice()

		var last_layer_y: float = _asteroid_slices[0][0].position.y
		var new_layer_y: float = last_layer_y - layer_spacing

		for asteroid in slice:
			asteroid.position.y = new_layer_y
			add_child(asteroid)

		_asteroid_slices.push_front(slice)
	
	pass
