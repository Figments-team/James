extends Node

var scene
var sceneLoader
signal load_finished

var useLoadAnimation

func _ready():
	set_process(false)

func loadScene(scenePath, useLoadAnim = false):
	useLoadAnimation = useLoadAnim
	sceneLoader = ResourceLoader.load_interactive(scenePath)
	if(useLoadAnimation):
		Overlay.showLoader()
	set_process(true)

func _process(delta):
	if(sceneLoader.poll() == ERR_FILE_EOF):
		set_process(false)
		var loadedScene = sceneLoader.get_resource()
		if(loadedScene != null):
			scene = loadedScene.instance()
			self.add_child(scene)
		if(useLoadAnimation):
			Overlay.hideLoader()
		emit_signal("load_finished")

func unloadScene(sceneName):
	for child in get_children():
		if(child.name == sceneName):
			child.queue_free()

func unloadAll():
	for child in get_children():
		child.queue_free()
