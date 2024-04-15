extends PopupPanel

@onready var label: Label = $VBoxContainer/Label

@export var text : String:
	set(value):
		label.text = value
		text = value
	get:
		return text
		
func _on_button_pressed() -> void:
	hide()
