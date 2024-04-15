extends Control

const HOVER  = preload("res://resources/hover.tres")
const NORMAL = preload("res://resources/normal.tres")

@onready var bg:                BackgroundComponent = $VBoxContainer/Background
@onready var popuptexture:      Button              = $VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/popupTexture
@onready var filedialog:        FileDialog          = $FileDialog
@onready var setOverlayOpacity: HSlider             = $VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/setOverlayOpacity
@onready var setImageOpacity:   HSlider             = $VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/setImageOpacity

var saved : backgroundCollection = backgroundCollection.new()

func _ready() -> void:
	# Reset the resouce (Dunno why this is necessary)
	saved.clear()
	
	# Connect the buttons
	for item : Control in get_tree().get_nodes_in_group("button"):
		item.add_theme_stylebox_override("hover", HOVER)
		item.add_theme_stylebox_override("normal", NORMAL)
		item.add_theme_stylebox_override("pressed", NORMAL)
		item.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

		if item is ColorPickerButton:
			item = item as ColorPickerButton
			item.color_changed.connect(func(param): processClick(item.name)) 
		elif item is HSlider:
			item = item as HSlider
			item.value_changed.connect(func(param): processClick(item.name)) 
		else:
			item.pressed.connect(processClick.bind(item.name)) 

	filedialog.file_selected.connect(loadTexture)
		
	# Set some defaults
	bg.startColor     = %setColorStart.color
	bg.endColor       = %setColorEnd.color
	bg.overlayOpacity = setOverlayOpacity.value
	bg.imageOpacity   = setImageOpacity.value
	
func processClick(menuItem : String):
	match menuItem:
		"popupTexture":      $FileDialog.popup_centered()
		"setOverlayOpacity": bg.overlayOpacity = setOverlayOpacity.value
		"setImageOpacity":   bg.imageOpacity   = setImageOpacity.value
		"setColorStart":     bg.startColor     = %setColorStart.color
		"setColorEnd":       bg.endColor       = %setColorEnd.color
		"darkenStart":       bg.startColor     = bg.startColor.darkened(.1)
		"lightenStart":      bg.startColor     = bg.startColor.lightened(.1)
		"darkenEnd":         bg.endColor       = bg.endColor.darkened(.1)
		"lightenEnd":        bg.endColor       = bg.endColor.lightened(.1)
		"save":              saveBackground()
		"show":              showLog()
			
	%setColorStart.color = bg.startColor
	%setColorEnd.color   = bg.endColor

func saveBackground():
	if bg.imageTexture == null:
		$AcceptDialog.text = "No texture Set"
		$AcceptDialog.show()
	else:
		var item : background = background.new(
			bg.imageTexture.resource_path, 
			bg.startColor, 
			bg.endColor, 
			bg.imageOpacity,
			bg.overlayOpacity
		)
		if saved.backgrounds.any(func(_item:background):
			return _item.compare(item)
		):
			$AcceptDialog.text = "Duplicate"
			$AcceptDialog.show()
		else:
			saved.add(item)
			$AcceptDialog.text = "Saved"
			$AcceptDialog.show()

func showLog():
	if saved.backgrounds.size() <= 0:
		$AcceptDialog.text = "Nothing saved"
		$AcceptDialog.show()
	else:
		$LogBook.loadColors(saved)
		$LogBook.show()
		
func loadTexture(file:String):
	var image : Image = Image.new()
	image.load(file)
	bg.imageTexture = ImageTexture.create_from_image(image)
	bg.imageTexture.resource_path = file
