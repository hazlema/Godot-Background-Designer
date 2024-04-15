class_name background extends Resource

@export var texture        : String
@export var startColor     : Color
@export var endColor       : Color
@export var imageOpacity   : float
@export var overlayOpacity : float
	
func _init(_texture: String, _startColor : Color, _endColor : Color, _imageOpacity: float, _overlayOpacity: float) -> void:
	texture        = _texture
	startColor     = _startColor
	endColor       = _endColor
	imageOpacity   = _imageOpacity
	overlayOpacity = _overlayOpacity

func compare(item:background) -> bool:
	return ((item.texture        == texture)        &&
			(item.startColor     == startColor)     &&
			(item.endColor       == endColor)       &&
			(item.imageOpacity   == imageOpacity)   &&
			(item.overlayOpacity == overlayOpacity))
	
func serialize() -> Dictionary:
	return { 
		"texture":        texture, 
		"startColor":     "#" + startColor.to_html(false), 
		"endColor":       '#' + endColor.to_html(false),
		"imageOpacity":   imageOpacity,
		"overlayOpacity": overlayOpacity
	}
