extends Control

var game_manager = null

func _ready() -> void:
	hide()
	$AnimationPlayer.play("RESET")
	game_manager = get_tree().current_scene.get_node_or_null("Gamemanager")

func resume():
	get_tree().paused = false
	hide()
	$AnimationPlayer.play_backwards("pause_blur")
	
func pause():
	get_tree().paused = true
	show()
	$AnimationPlayer.play("pause_blur")
	
func test_esc():
	if game_manager != null and game_manager.is_game_over:
		return

	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		resume()

func _process(delta: float) -> void:
	test_esc()

func _on_resume_pressed() -> void:
	resume()

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().quit()
