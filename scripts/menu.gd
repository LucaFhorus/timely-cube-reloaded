extends Control

@onready var new_game_button = $VBoxContainer2/VBoxContainer/NewGameButton
@onready var credits_button = $VBoxContainer2/VBoxContainer/CreditsButton
@onready var quit_button = $VBoxContainer2/VBoxContainer/QuitButton
@onready var button_audio = $VBoxContainer2/VBoxContainer/AudioStreamPlayer

func _ready() -> void:
	new_game_button.pressed.connect(start_new_game)
	credits_button.pressed.connect(view_credits)
	quit_button.pressed.connect(quit_game)
	new_game_button.mouse_entered.connect(play_sound)
	credits_button.mouse_entered.connect(play_sound)
	quit_button.mouse_entered.connect(play_sound)
	
func _process(delta: float) -> void:
	pass

func start_new_game():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func quit_game():
	get_tree().quit()

func view_credits():
	get_tree().change_scene_to_file("res://scenes/credits.tscn")

func play_sound():
	button_audio.play()
