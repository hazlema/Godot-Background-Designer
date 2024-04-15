class_name BackgroundComponent extends Control

@export var imageTexture : Texture:
	get:
		return imageTexture
	set(value):
		imageTexture = value
		update()
	
@export var startColor : Color = Color.WHITE:
	get:
		return startColor
	set(value):
		startColor = value
		update()

@export var endColor : Color = Color.BLACK:
	get:
		return endColor
	set(value):
		endColor = value
		update()

@export_range(0.0, 1.0) var overlayOpacity : float = 0.7:
	get:
		return overlayOpacity
	set(value):
		overlayOpacity = value
		update()

@export_range(0.0, 1.0) var imageOpacity : float = 0.7:
	get:
		return imageOpacity
	set(value):
		imageOpacity = value
		update()

var imgTexture : TextureRect
var subTexture : TextureRect

func init():
	set_anchors_preset(Control.PRESET_FULL_RECT)
	
func initImgTexture():
	imgTexture = TextureRect.new()
	imgTexture.name = "imgTexture"
	imgTexture.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(imgTexture)

func initSubTexture():
	subTexture = TextureRect.new()
	subTexture.name = "subTexture"
	subTexture.set_anchors_preset(Control.PRESET_FULL_RECT)
	imgTexture.add_child(subTexture)

func setTexture():
	imgTexture.texture = imageTexture
	imgTexture.self_modulate.a = imageOpacity

func buildGradient():
	var gradient2D  : GradientTexture2D = GradientTexture2D.new()
	var gradient    : Gradient          = Gradient.new()
	var _startColor : Color             = Color(startColor.r, startColor.g, startColor.b, overlayOpacity)
	var _endColor   : Color             = Color(endColor.r, endColor.g, endColor.b, overlayOpacity)
	
	gradient2D.gradient = gradient
	
	gradient.set_color(0, _startColor)
	gradient.set_color(1, _endColor)
	
	gradient2D.fill_from = Vector2.ZERO
	gradient2D.fill_to   = Vector2(0, 1)
	subTexture.texture   = gradient2D
	
func update():
	if !is_node_ready():
		await ready

	setTexture()
	buildGradient()
	
func _ready() -> void:
	init()
	initImgTexture()
	initSubTexture()
	update()
