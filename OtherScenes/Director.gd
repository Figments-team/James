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
	return get_tree().create_timer(seconds)

##############
## Routines ##
##############

func gameOpening():
	Root.loadScene("res://MainScenes/Splash.tscn") # Load Splash
	yield(Root, "load_finished") # Wait for Splash loading
	
	yield(Director.wait(1), "timeout")
	
	Overlay.fadeOutBlack() # Start fade out from black
	yield(Overlay, "fade_finished") # Wait for animation
	
	yield(Root.sceneInstance.self_direction(), "completed") # Wait for self direction
	
	Overlay.fadeInBlack() # Start fade in to black
	yield(Overlay, "fade_finished") # Wait for animation
	
	Root.unloadScene("Splash")
	Root.loadScene("res://MainScenes/MainMenu.tscn") # Load MainMenu
	yield(Root, "load_finished") # Wait for MainMenu loading
	
	yield(Director.wait(1), "timeout")
	
	BGM.playLooped("res://Assets/Music/Who James is.wav")
	Overlay.fadeOutBlack() # Start fade out from black
	yield(Overlay, "fade_finished") # Wait for animation
