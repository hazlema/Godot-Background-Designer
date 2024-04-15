extends Panel

const NORMAL = preload("res://resources/normal.tres")
const HOVER = preload("res://resources/hover.tres")

@onready var texture:        Label = $MarginContainer/VBoxContainer/HBoxContainer/setTexturePath
@onready var startColor:     Label = $MarginContainer/VBoxContainer/HBoxContainer2/setStartColor
@onready var endColor:       Label = $MarginContainer/VBoxContainer/HBoxContainer2/setEndColor
@onready var imageOpacity:   Label = $MarginContainer/VBoxContainer/HBoxContainer2/setImageOpacity
@onready var overlayOpacity: Label = $MarginContainer/VBoxContainer/HBoxContainer2/setOverlayOpacity

func setLabels(_texture, _startColor, _endColor, _imageOpacity, _overlayOpacity):
	texture.text        = _texture
	startColor.text     = "#" + _startColor
	endColor.text       = "#" + _endColor
	imageOpacity.text   = str(_imageOpacity)
	overlayOpacity.text = str(_overlayOpacity)

func _on_mouse_entered() -> void:
	add_theme_stylebox_override("panel", HOVER)

func _on_mouse_exited() -> void:
	add_theme_stylebox_override("panel", NORMAL)
