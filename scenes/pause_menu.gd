extends Control

func resume():
	get_tree().paused = false
	hide()
	$AnimationPlayer.play_backwards("pause_blur")
	
func pause():
	get_tree().paused = true
	show()
	$AnimationPlayer.play("pause_blur")
	

func test_esc():
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		resume()
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	$AnimationPlayer.play("RESET")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	test_esc()


func _on_resume_pressed() -> void:
	resume()


func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	get_tree().quit()
