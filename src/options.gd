class_name Options
extends RefCounted

const CONFIG_FILE := &"user://config.ini"


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

		return window_mode == DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN


static func write_to_file(config: ConfigFile = null) -> void:
	if config == null:
		config = ConfigFile.new()
		if config.load(CONFIG_FILE) != OK: return

	config.set_value("Graphics", "fullscreen", fullscreen)

	# sound levels
	# for bus in SoundCtl.adjustable_sound_buses():
	# 	config.set_value(SOUND_VOLUME,\
	# 		AudioServer.get_bus_name(bus),\
	# 		AudioServer.get_bus_volume_db(bus))

	config.save(CONFIG_FILE)


static func load_from_file() -> void:
	var config = ConfigFile.new()
	var err = config.load(CONFIG_FILE)

	if err != OK:
		if err == ERR_FILE_NOT_FOUND:
			write_to_file(config)
		return

	fullscreen = config.get_value("Graphics", "fullscreen", true)

	# sound levels
	# for bus in SoundCtl.adjustable_sound_buses():
	# 	var value = config.get_value(SOUND_VOLUME,\
	# 		AudioServer.get_bus_name(bus),\
	# 		AudioServer.get_bus_volume_db(bus))
	#
	# 	SoundCtl.set_volume(bus,\
	# 			clamp(value, SoundCtl.MIN_VOLUME, SoundCtl.MAX_VOLUME))
