extends Area3D

@export var rotation_speed := Vector3(1.2, 0.9, 1.1)

func _ready() -> void:
	print("Asteroid ready")
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	# rotate_x(rotation_speed.x * delta)
	# rotate_y(rotation_speed.y * delta)
	# rotate_z(rotation_speed.z * delta)
	pass

func _on_body_entered(body: Node) -> void:
	print("Entered by:", body.name)

	if body.is_in_group("player"):
		print("Player hit asteroid")

		var manager = get_tree().get_first_node_in_group("game_manager")
		print("Manager found:", manager)

		if manager:
			manager.game_over()
