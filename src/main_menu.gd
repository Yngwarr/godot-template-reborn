@tool
extends Node2D

@export_group("Internal")
@export var quit_button: Button:
	set(value):
		quit_button = value
		update_configuration_warnings()


func _ready() -> void:
	if not Engine.is_editor_hint():
		if OS.has_feature('web'):
			quit_button.visible = false

		quit_button.pressed.connect(quit_game)


func _get_configuration_warnings() -> PackedStringArray:
	var warns: PackedStringArray = []

	if ProjectSettings.get_setting('application/config/name') == 'Game Template':
		warns.push_back("Please, change the game's name.")

	if not quit_button:
		warns.push_back("Quit button must not be null")

	return warns


func quit_game() -> void:
	get_tree().quit()
