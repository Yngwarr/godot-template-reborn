@tool
extends Node2D


@export_file("*.tscn") var game_scene_name: String:
	set(value):
		game_scene_name = value
		update_configuration_warnings()

@export_group("Internal")
@export var quit_button: Button
@export var start_button: Button
@export var credits_button: Button
@export var credits_window: Window
@export var options_button: Button
@export var options_window: Window


func _ready() -> void:
	if not Engine.is_editor_hint():
		if OS.has_feature('web'):
			quit_button.visible = false

		start_button.pressed.connect(start_game)
		credits_button.pressed.connect(func(): credits_window.show())
		options_button.pressed.connect(func(): options_window.show())
		quit_button.pressed.connect(quit_game)


func _get_configuration_warnings() -> PackedStringArray:
	var warns: PackedStringArray = []

	if ProjectSettings.get_setting('application/config/name') == 'Game Template':
		warns.push_back("Please, change the game's name.")

	return warns


func start_game() -> void:
	Global.change_scene(game_scene_name)


func quit_game() -> void:
	get_tree().quit()
