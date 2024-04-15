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
	var build : String = ""
	var json = FileAccess.open(path, FileAccess.WRITE)

	# Build the json
	for item in backgrounds:
		build += "\t" + str(item).replace('\\', '/') + ",\n"
	build = build.left(build.length() - 2) + "\n"

	# Write
	json.store_string('{ "backgrounds" : [\n')
	json.store_string(build)
	json.store_string("]}\n")
	json.close()
