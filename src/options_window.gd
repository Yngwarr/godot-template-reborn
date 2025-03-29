extends Popup


@export_group("Internal")
@export var first_to_focus: Control
@export var fullscreen_toggle: CheckButton
@export var back_button: Button


func _ready() -> void:
	visibility_changed.connect(on_visibility_changed)
	fullscreen_toggle.toggled.connect(on_fullscreen_toggled)
	back_button.pressed.connect(hide)


func on_visibility_changed() -> void:
	if first_to_focus:
		first_to_focus.grab_focus()

	if visible == true:
		fullscreen_toggle.button_pressed = Options.fullscreen


func on_fullscreen_toggled(on: bool) -> void:
	Options.fullscreen = on
