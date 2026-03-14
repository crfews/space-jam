extends Control

@onready var game_over_menu = $"../CanvasLayer/GameOverMenu"
var is_game_over: bool = false

func game_over() -> void:
	if is_game_over:
		return

	is_game_over = true
	game_over_menu.visible = true
	get_tree().paused = true
