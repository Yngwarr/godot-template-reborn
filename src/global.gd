extends Node


static func toggle_fullscreen() -> void:
	var is_fullscreen := Options.fullscreen
	Options.fullscreen = !is_fullscreen


func _input(event: InputEvent) -> void:
	if (
		event is InputEventKey
		and event.pressed
		and not event.echo
		and event.keycode == KEY_ENTER
		and event.alt_pressed
	):
		toggle_fullscreen()


## For some reason, Godot doesn't allow you to have dependency loops when using
## PackedScene, rendering it impossible to use it in some situation (e.g. for a
## restart button on the game over screen). Hence, file name.
func change_scene(scene_file_name: String) -> void:
	# we expect a new scene to be unpaused
	get_tree().paused = true
	get_tree().change_scene_to_file(scene_file_name)
