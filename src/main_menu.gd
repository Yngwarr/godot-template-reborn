@tool
extends Node2D


@export_file("*.tscn") var game_scene_name: String:
	set(value):
		game_scene_name = value
		update_configuration_warnings()

@export_group("Internal")
@export var quit_button: Button:
	set(value):
		quit_button = value
		update_configuration_warnings()

@export var start_button: Button:
	set(value):
		start_button = value
		update_configuration_warnings()


func _ready() -> void:
	if not Engine.is_editor_hint():
		if OS.has_feature('web'):
			quit_button.visible = false

		start_button.pressed.connect(start_game)
		quit_button.pressed.connect(quit_game)


func _get_configuration_warnings() -> PackedStringArray:
	var warns: PackedStringArray = []

	if ProjectSettings.get_setting('application/config/name') == 'Game Template':
		warns.push_back("Please, change the game's name.")

	if not quit_button:
		warns.push_back("Quit button must not be null.")

	if not start_button:
		warns.push_back("Start button must not be null.")

	if not game_scene_name:
		warns.push_back("Game scene name must be set.")

	return warns


func start_game() -> void:
	Global.change_scene(game_scene_name)


func quit_game() -> void:
	get_tree().quit()
