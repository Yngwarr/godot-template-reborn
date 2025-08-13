class_name Pause
extends Node

## Must have [code]process_mode == PROCESS_MODE_WHEN_PAUSED[/code].
@export var pause_screen: PauseMenu

var to_drop_next := false
var last_focused: Control


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(&"game_pause"):
		if get_tree().paused:
			unpause(false)
		else:
			pause()


func pause() -> void:
	if to_drop_next:
		to_drop_next = false
		return

	last_focused = get_viewport().gui_get_focus_owner()
	to_drop_next = false
	get_tree().paused = true
	pause_screen.pause()


func unpause(ignore_drop := true) -> void:
	if to_drop_next and not ignore_drop:
		to_drop_next = false
		return

	get_tree().paused = false
	pause_screen.unpause()

	if last_focused:
		last_focused.grab_focus()


func drop_next() -> void:
	to_drop_next = true
