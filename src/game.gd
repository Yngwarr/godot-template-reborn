extends Node2D

@export_group("Internal")
@export var pause_ctl: Pause
@export var pause_menu: PauseMenu

func _ready() -> void:
	pause_menu.modal_open.connect(pause_ctl.drop_next)
	pause_menu.resume_pressed.connect(pause_ctl.unpause)

	$AnimationPlayer.play(&"idle", .25)
