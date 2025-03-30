@tool
class_name PauseMenu
extends CanvasLayer

## Your average pause menu you can use to rage quit the game, go outside and
## touch some grass.

signal modal_open
signal resume_pressed


@export_file("*.tscn") var back_scene_name: String:
	set(value):
		back_scene_name = value
		update_configuration_warnings()

@export_group("Internal")
@export var resume_button: Button
@export var options_button: Button
@export var quit_button: Button
@export var options_menu: Popup
@export var quit_dialog: ConfirmationDialog


func _ready() -> void:
	resume_button.pressed.connect(on_resume_pressed)
	options_button.pressed.connect(func(): options_menu.visible = true)
	quit_button.pressed.connect(quit_dialog.show)
	options_menu.visibility_changed.connect(options_toggled)
	quit_dialog.confirmed.connect(func(): Global.change_scene(back_scene_name))

	resume_button.grab_focus()


func _get_configuration_warnings() -> PackedStringArray:
	var warns: PackedStringArray = []

	if not back_scene_name:
		warns.push_back("back_scene_name can't be empty.")

	return warns


func on_resume_pressed() -> void:
	resume_pressed.emit()


func options_toggled() -> void:
	if options_menu.visible:
		return
	modal_open.emit()


func pause() -> void:
	show()
	resume_button.grab_focus()


func unpause() -> void:
	hide()
