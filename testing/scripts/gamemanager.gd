extends Node3D

@onready var score_display = $"../CanvasLayer/ScoreLabel"
@onready var game_over_menu = $"../CanvasLayer/GameOverMenu"
<<<<<<< Updated upstream
=======
@onready var final_score_label = $"../CanvasLayer/GameOverMenu/finalscore"

>>>>>>> Stashed changes
var score: int = 0
var is_game_over: bool = false

func _ready() -> void:
	print("GameManager ready")
	
	score_display.text = "Score: 0"
	game_over_menu.hide()

func _on_timer_timeout() -> void:
	if is_game_over:
		return

	score += 1
	score_display.text = "Score: " + str(score)
	print("Score:", score)

func game_over() -> void:
	if is_game_over:
		return

	is_game_over = true
	print("GAME OVER TRIGGERED")
	game_over_menu.show()
	get_tree().paused = true
	final_score_label.text = "Score: " + str(score)

func _on_playagain_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
