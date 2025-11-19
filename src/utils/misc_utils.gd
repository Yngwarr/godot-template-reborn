class_name MiscUtils
extends Object


static func get_focus_owner(this: Node) -> Control:
	return this.get_viewport().gui_get_focus_owner()


static func try_connect(p_signal: Signal, p_func: Callable) -> void:
	if not p_signal.is_connected(p_func):
		p_signal.connect(p_func)


static func try_disconnect(p_signal: Signal, p_func: Callable) -> void:
	if p_signal.is_connected(p_func):
		p_signal.disconnect(p_func)


static func eerp(a: float, b: float, t: float) -> float:
	return a * exp(t * log(b / a))


static func random_pitch(base: float, offset := .1) -> float:
	assert(offset <= base)

	return eerp(base - offset, base + offset, randf())
