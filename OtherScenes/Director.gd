extends AnimationPlayer

#############
## Manager ##
#############

func _ready():
	yield(Root, "ready") # _ready of Director is called before Root is ready, so we wait for it
	play("Opening")

var currentState:GDScriptFunctionState

func wait():
	if(currentState.is_valid()):
		stop(false)
		yield(currentState, "completed")
		play()

###########
## Tools ##
###########

onready var Root = $"/root/Root"

func showLoader():
	Overlay.showLoader()

func hideLoader():
	Overlay.hideLoader()

func loadScene(scenePath:String, useLoader:bool = false):
	if(useLoader):
		Overlay.showLoader()
	currentState = Root.loadScene(scenePath)

func removeScene(sceneName:String):
	Root.removeScene(sceneName)

func addScene():
	Root.addScene()

func replaceScene(sceneToRemove:String):
	removeScene(sceneToRemove)
	addScene()

func directScene(sceneName:String):
	currentState = Root.callSelfDirection(sceneName)

func fadeIn(duration:int = 1):
	currentState = Overlay.fadeInBlack(duration) # Start fade in to black and wait

func fadeOut(duration:int = 1):
	currentState = Overlay.fadeOutBlack(duration) # Start fade out from black and wait

func playMusic(path:String):
	Overlay.playMusic(path)
