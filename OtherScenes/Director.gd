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

func wait(seconds:int):
	yield(get_tree().create_timer(seconds), "timeout")

func loadAndAdd(scenePath:String, useLoader:bool = false):
	if(useLoader):
		Overlay.showLoader()
	Root.loadScene(scenePath) # Load scene
	yield(Root, "load_finished") # Wait for scene to load
	if(useLoader):
		Overlay.hideLoader()

func loadAndReplace(scenePath:String, useLoader:bool = false):
	if(useLoader):
		Overlay.showLoader()
	Root.unloadScene() # Unload previous scene
	Root.loadScene(scenePath) # Load scene
	yield(Root, "load_finished") # Wait for scene to load
	if(useLoader):
		Overlay.hideLoader()

func directScene(waitEnd:bool = true):
	if(waitEnd):
		yield(Root.scene.self_direction(), "completed")
	else:
		Root.scene.self_direction()

func fadeIn():
	yield(Overlay.fadeInBlack(), "completed") # Start fade in to black and wait

func fadeOut():
	yield(Overlay.fadeOutBlack(), "completed") # Start fade out from black and wait

func playMusic(path:String):
	Overlay.playMusic(path)

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
	playMusic("res://Assets/Music/Who James is.wav")
	yield(fadeOut(), "completed")
	yield(directScene(), "completed")
