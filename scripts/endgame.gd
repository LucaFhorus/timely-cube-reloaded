extends Control

@onready var new_game_button = $VBoxContainer2/VBoxContainer/NewGameButton
@onready var quit_button = $VBoxContainer2/VBoxContainer/QuitButton

func _ready() -> void:
	new_game_button.pressed.connect(start_new_game)
	quit_button.pressed.connect(quit_game)

func start_new_game():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func quit_game():
	get_tree().quit()
