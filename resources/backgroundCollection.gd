class_name backgroundCollection extends Resource

@export var backgrounds = [background]

func add(item: background):
	backgrounds.push_back(item)
	
func clear():
	backgrounds.clear()
	
func dump():
	for item in backgrounds:
		print(item)
		
func saveRes(path : String):
	ResourceSaver.save(self, path)

func saveJSON(path : String):
	var build = []
	for item : background in backgrounds:
		build.append(item.serialize())

	var json = FileAccess.open(path, FileAccess.WRITE)
	json.store_string(JSON.stringify({ "backgrounds" : build }, "\t"))
	json.close()
