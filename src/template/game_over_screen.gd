@tool
extends CanvasLayer


@export_file("*.tscn") var back_scene_name: String:
	set(value):
		back_scene_name = value
		update_configuration_warnings()

@export_group("Internal")
@export var retry_button: Button
@export var quit_button: Button


func _ready() -> void:
	retry_button.pressed.connect(func(): get_tree().reload_current_scene())
	quit_button.pressed.connect(func(): Global.change_scene(back_scene_name))


func _get_configuration_warnings() -> PackedStringArray:
	var warns: PackedStringArray = []

	if not back_scene_name:
		warns.push_back("back_scene_name can't be empty.")

	return warns
