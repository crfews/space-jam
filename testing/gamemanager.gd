extends Node3D

@onready var score_display = $UI/Score_display

var score: int = 0

func _ready() -> void:
	print("Game ready")
	score_display.text = "Score: 0"

func _on_score_timer_timeout() -> void:
	score += 1
	score_display.text = "Score: " + str(score)
