@tool
extends Window

const CREDITS := """
[center][wave amp=50.0 freq=5.0 connected=1]%s[/wave][/center]

Brought to you by:
[ul bullet=‣]
Yngvarr — code, sound, game design;
Syudzius — art, game design.
[/ul]

With use of amazing third-party assets:
[ul bullet=‣]
[url=https://plus.excalidraw.com/excalifont]Excalifont[/url] by Excalidraw team;
[/ul]

And these wonderful tools:
[ul bullet=‣]
[url=https://godotengine.org/]Godot Engine[/url] by Godot contributors.
[url=https://www.bitwig.com/]Bitwig Studio[/url] by Bitwig GmbH.
[url=https://www.aseprite.org/]Aseprite[/url] by Igara Studio S.A.
[/ul]

Special thanks to all my homies! 🐺
"""

@export_group("Internal")
@export var label: RichTextLabel


func _ready() -> void:
	label.text = CREDITS % ProjectSettings.get_setting("application/config/name")

	if Engine.is_editor_hint():
		close_requested.connect(hide)
		label.meta_clicked.connect(on_meta_clicked)


func on_meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta))
