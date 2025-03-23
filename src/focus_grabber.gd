@tool
class_name FocusGrabber
extends Node

## Sets focus to a given control on ready.

@export var first_to_focus: Control:
    set(value):
        first_to_focus = value
        update_configuration_warnings()


func _ready() -> void:
    if not Engine.is_editor_hint():
        if first_to_focus:
            first_to_focus.grab_focus()


func _get_configuration_warnings() -> PackedStringArray:
    var warns: PackedStringArray = []

    if first_to_focus == null:
        warns.push_back("First to Focus must not be empty.")

    return warns
