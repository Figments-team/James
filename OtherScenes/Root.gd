extends Node

var sceneLoader
signal load_finished

func _ready():
	set_process(false)

func loadScene(scenePath:String):
	sceneLoader = ResourceLoader.load_interactive(scenePath)
	set_process(true)
	yield(self, "load_finished")

func _process(delta):
	if(sceneLoader.poll() == ERR_FILE_EOF):
		set_process(false)
		emit_signal("load_finished")

func addScene():
	if(sceneLoader.get_resource() != null):
		self.add_child(sceneLoader.get_resource().instance())

func indexOf(sceneName:String):
	for n in get_child_count():
		if(get_children()[n].name == sceneName):
			return n

func callSelfDirection(sceneName:String):
	get_child(indexOf(sceneName)).get_node("SelfDirector").play("SelfDirection")
	yield(get_child(indexOf(sceneName)).get_node("SelfDirector"), "animation_finished")

func removeScene(sceneName:String):
	if(sceneName != null):
		for child in get_children():
			if(child.name == sceneName):
				child.queue_free()

func unloadAll():
	for child in get_children():
		child.queue_free()
