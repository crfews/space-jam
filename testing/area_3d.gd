extends Area3D

@export var rotation_speed := Vector3(1.2, 0.9, 1.1)

func _process(delta: float) -> void:
	rotate_x(rotation_speed.x * delta)
	rotate_y(rotation_speed.y * delta)
	rotate_z(rotation_speed.z * delta)
