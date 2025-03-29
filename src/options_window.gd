extends Popup

@export_group("Internal")
@export var first_to_focus: Control
@export var fullscreen_toggle: CheckButton
@export var master_slider: Slider
@export var sfx_slider: Slider
@export var music_slider: Slider
@export var back_button: Button


func _ready() -> void:
	master_slider.min_value = SoundCtl.MIN_VOLUME
	master_slider.max_value = SoundCtl.MAX_VOLUME
	sfx_slider.min_value = SoundCtl.MIN_VOLUME
	sfx_slider.max_value = SoundCtl.MAX_VOLUME
	music_slider.min_value = SoundCtl.MIN_VOLUME
	music_slider.max_value = SoundCtl.MAX_VOLUME

	visibility_changed.connect(on_visibility_changed)
	fullscreen_toggle.toggled.connect(func(x): Options.fullscreen = x)
	master_slider.value_changed.connect(func(x): Options.master_volume = x)
	sfx_slider.value_changed.connect(func(x): Options.sfx_volume = x)
	music_slider.value_changed.connect(func(x): Options.music_volume = x)
	back_button.pressed.connect(hide)


func on_visibility_changed() -> void:
	if first_to_focus:
		first_to_focus.grab_focus()

	if visible == true:
		# set controls to the correct values
		fullscreen_toggle.button_pressed = Options.fullscreen
		master_slider.value = Options.master_volume
		sfx_slider.value = Options.sfx_volume
		music_slider.value = Options.music_volume
	else:
		Options.write_to_file()
