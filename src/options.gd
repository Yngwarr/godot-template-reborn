class_name Options
extends RefCounted

static var fullscreen: bool:
	set(value):
		var new_mode := (
			DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN
			if value
			else DisplayServer.WindowMode.WINDOW_MODE_MAXIMIZED
		)

		DisplayServer.window_set_mode(new_mode)
	get():
		var window_mode := DisplayServer.window_get_mode()
		print(window_mode)

		return window_mode == DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN


func write_to_file() -> void:
	pass
