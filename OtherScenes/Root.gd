extends Node

var sceneLoader
var packedScene
var sceneInstance
signal load_finished

func _ready():
	set_process(false)

func loadScene(scenePath):
	Overlay.showLoader()
	sceneLoader = ResourceLoader.load_interactive(scenePath)
	set_process(true)

func _process(delta):
	if(sceneLoader.poll() == ERR_FILE_EOF):
		set_process(false)
		packedScene = sceneLoader.get_resource()
		if(packedScene != null):
			sceneInstance = packedScene.instance()
			self.add_child(sceneInstance)
		Overlay.hideLoader()
		emit_signal("load_finished")

func unloadScene(sceneName):
	for child in get_children():
		if(child.name == sceneName):
			child.queue_free()

func clear():
	sceneInstance = null
	packedScene = null
	sceneLoader = null

func unloadAll():
	for child in get_children():
		child.queue_free()
