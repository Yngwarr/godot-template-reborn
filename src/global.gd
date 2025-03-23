extends Node

static func toggle_fullscreen() -> void:
    var window_mode := DisplayServer.window_get_mode()

    if window_mode == DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN:
        DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_MAXIMIZED)
    else:
        DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN)


func _input(event: InputEvent) -> void:
    if event is InputEventKey \
            and event.pressed \
            and not event.echo \
            and event.keycode == KEY_ENTER \
            and event.alt_pressed:
        toggle_fullscreen()
