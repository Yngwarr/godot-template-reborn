class_name MiscUtils
extends Object


static func get_focus_owner(this: Node) -> Control:
	return this.get_viewport().gui_get_focus_owner()
