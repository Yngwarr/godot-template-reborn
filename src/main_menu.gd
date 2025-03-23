@tool
extends Node2D

func _get_configuration_warnings() -> PackedStringArray:
    var warns: PackedStringArray = []

    if ProjectSettings.get_setting('application/config/name') == 'Game Template':
        warns.push_back("Please, change the game's name.")

    return warns
