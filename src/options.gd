class_name Options
extends RefCounted

const CONFIG_FILE := &"user://config.ini"
const GRAPHICS_SECTION := "Graphics"
const FULLSCREEN_OPTION := "fullscreen"
const VOLUME_SECTION := "SoundVolume"
const MASTER_BUS := &"Master"
const SFX_BUS := &"SFX"
const MUSIC_BUS := &"Music"

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

static var master_volume: float:
	set(value):
		var bus_id := AudioServer.get_bus_index(MASTER_BUS)
		assert(bus_id >= 0, "the bus must exist")
		SoundCtl.set_volume(bus_id, value)
	get():
		var bus_id := AudioServer.get_bus_index(MASTER_BUS)
		return SoundCtl.get_volume(bus_id)

static var sfx_volume: float:
	set(value):
		var bus_id := AudioServer.get_bus_index(SFX_BUS)
		assert(bus_id >= 0, "the bus must exist")
		SoundCtl.set_volume(bus_id, value)
	get():
		var bus_id := AudioServer.get_bus_index(SFX_BUS)
		return SoundCtl.get_volume(bus_id)

static var music_volume: float:
	set(value):
		var bus_id := AudioServer.get_bus_index(MUSIC_BUS)
		assert(bus_id >= 0, "the bus must exist")
		SoundCtl.set_volume(bus_id, value)
	get():
		var bus_id := AudioServer.get_bus_index(MUSIC_BUS)
		return SoundCtl.get_volume(bus_id)


static func write_to_file(config: ConfigFile = null) -> void:
	if config == null:
		config = ConfigFile.new()
		if config.load(CONFIG_FILE) != OK:
			return

	config.set_value(GRAPHICS_SECTION, FULLSCREEN_OPTION, fullscreen)
	config.set_value(VOLUME_SECTION, MASTER_BUS, master_volume)
	config.set_value(VOLUME_SECTION, SFX_BUS, sfx_volume)
	config.set_value(VOLUME_SECTION, MUSIC_BUS, music_volume)

	config.save(CONFIG_FILE)


static func load_from_file() -> void:
	var config = ConfigFile.new()
	var err = config.load(CONFIG_FILE)

	if err != OK:
		if err == ERR_FILE_NOT_FOUND:
			write_to_file(config)
		return

	fullscreen = config.get_value(GRAPHICS_SECTION, FULLSCREEN_OPTION, true)
	master_volume = config.get_value(VOLUME_SECTION, MASTER_BUS, 0)
	sfx_volume = config.get_value(VOLUME_SECTION, SFX_BUS, 0)
	music_volume = config.get_value(VOLUME_SECTION, MUSIC_BUS, 0)
