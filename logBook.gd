extends PopupPanel

const LOGENTRY = preload("res://logEntry.tscn")

@onready var items: VBoxContainer = $VBoxContainer/ItemList/VBoxContainer
@onready var filedialog: FileDialog = $FileDialog

var saved : backgroundCollection

func clear():
	for item in items.get_children():
		item.queue_free()
		
#func loadColors(_saved: backgroundCollection):
	#saved = _saved
	#clear()
	#for item in _saved.backgrounds:
		#var entry = LOGENTRY.instantiate()
		#items.add_child(entry)
		#entry.setLabels(item.texture, item.startColor.to_html(false), item.endColor.to_html(false), item.imageOpacity, item.overlayOpacity)

func loadColors(_saved: backgroundCollection):
	saved = _saved
	clear()
	for item in _saved.backgrounds:
		var entry = LOGENTRY.instantiate()
		items.add_child(entry)
		entry.setLabels(item)

func _on_file_dialog_file_selected(path: String) -> void:
	if filedialog.title == "Resource Export":
		saved.saveRes(path)
	else:
		saved.saveJSON(path)
		
func _on_tres_export_pressed() -> void:
	filedialog.clear_filters()
	filedialog.title = "Resource Export"
	filedialog.add_filter("*.tres;Text Resource File")
	filedialog.add_filter("*.res;Binary Resource File")
	filedialog.add_filter("*.tres,*.res;Resource File")
	filedialog.show()

func _on_json_export_pressed() -> void:
	filedialog.clear_filters()
	filedialog.title = "JSON Export"
	filedialog.add_filter("*.json;JSON Files")
	filedialog.show()
