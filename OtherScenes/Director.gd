extends Node

#############
## Manager ##
#############

func _ready():
	yield(Root, "ready") # _ready of Director is called before Root is ready, so we wait for it
	gameOpening()

###########
## Tools ##
###########

onready var Root = $"/root/Root"

func getCurrent():
	return Root.get_children()

func searchChildrenOfName(children, name):
	if children == null:
		children = getCurrent()
	var foundChildren = Array()
	for child in children:
		if child.get_name() == name:
			foundChildren.append(child)
	return foundChildren

func searchChildrenOfType(children, type):
	if children == null:
		children = getCurrent()
	var foundChildren = Array()
	for child in children:
		if child.get_class() == type:
			foundChildren.append(child)
	return foundChildren

func wait(seconds):
	yield(get_tree().create_timer(seconds), "timeout")

func loadAndAdd(scenePath, useLoader = false):
	if(useLoader):
		Overlay.showLoader()
	Root.loadScene(scenePath) # Load scene
	yield(Root, "load_finished") # Wait for scene to load
	if(useLoader):
		Overlay.hideLoader()

func loadAndReplace(scenePath, useLoader = false):
	if(useLoader):
		Overlay.showLoader()
	Root.unloadScene() # Unload previous scene
	Root.loadScene(scenePath) # Load scene
	yield(Root, "load_finished") # Wait for scene to load
	if(useLoader):
		Overlay.hideLoader()

func directScene():
	yield(Root.scene.self_direction(), "completed") # Wait for self direction

func fadeIn():
	Overlay.fadeInBlack() # Start fade in to black
	yield(Overlay, "fade_finished") # Wait for animation

func fadeOut():
	Overlay.fadeOutBlack() # Start fade out from black
	yield(Overlay, "fade_finished") # Wait for animation

##############
## Routines ##
##############

func gameOpening():
	yield(loadAndReplace("res://MainScenes/Splash.tscn"), "completed")
	yield(wait(1), "completed")
	yield(fadeOut(), "completed")
	yield(directScene(), "completed")
	yield(fadeIn(), "completed")
	yield(loadAndReplace("res://MainScenes/MainMenu.tscn"), "completed")
	yield(wait(1), "completed")
	BGM.playLooped("res://Assets/Music/Who James is.wav")
	yield(fadeOut(), "completed")
