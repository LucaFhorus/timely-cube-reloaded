extends Control

@onready var back_to_menu_button = $VBoxContainer2/BackToMenuButton

func _ready() -> void:
	back_to_menu_button.pressed.connect(go_back_to_menu)

func go_back_to_menu():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
