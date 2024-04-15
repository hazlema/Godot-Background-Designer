extends Panel

const NORMAL = preload("res://resources/normal.tres")
const HOVER = preload("res://resources/hover.tres")

@onready var texture:        Label = $MarginContainer/VBoxContainer/HBoxContainer/setTexturePath
@onready var startColor:     Label = $MarginContainer/VBoxContainer/HBoxContainer2/setStartColor
@onready var endColor:       Label = $MarginContainer/VBoxContainer/HBoxContainer2/setEndColor
@onready var imageOpacity:   Label = $MarginContainer/VBoxContainer/HBoxContainer2/setImageOpacity
@onready var overlayOpacity: Label = $MarginContainer/VBoxContainer/HBoxContainer2/setOverlayOpacity

var item:background

func setLabels(_item:background):
	item = _item
	texture.text        = item.texture
	startColor.text     = "#" + item.startColor.to_html(false)
	endColor.text       = "#" + item.endColor.to_html(false)
	imageOpacity.text   = str(item.imageOpacity)
	overlayOpacity.text = str(item.overlayOpacity)

func _on_mouse_entered() -> void:
	add_theme_stylebox_override("panel", HOVER)

func _on_mouse_exited() -> void:
	add_theme_stylebox_override("panel", NORMAL)

func _on_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_select"):
		Events.sendLoadBackground(item)
