class_name InputUtils
extends Object


## to use with Area.input_event
static func is_mouse_button_pressed(
	event: InputEvent, button_index: int = MOUSE_BUTTON_LEFT
) -> bool:
	if event is not InputEventMouseButton:
		return false

	if event.button_index != button_index:
		return false

	if not event.pressed:
		return false

	return true
