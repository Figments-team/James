extends AnimationPlayer

#############
## Manager ##
#############

func _ready():
	#Overlay.cutOutBlack()
	yield(Root, "ready") # _ready of Director is called before Root is ready, so we wait for it
	play("Opening")

var asyncQueue:Array

func clearAsyncQueue():
	asyncQueue.clear()

func waitForAsync():
	for asyncOp in asyncQueue:
		if(asyncOp.is_valid()):
			stop(false)
			yield(asyncOp, "completed")
			play()
	clearAsyncQueue()

###########
## Tools ##
###########

onready var Root = $"/root/Root"

func showLoader():
	Overlay.showLoader()

func hideLoader():
	Overlay.hideLoader()

func loadScene(scenePath:String):
	asyncQueue.append(Root.loadScene(scenePath))

func removeScene(sceneName:String):
	Root.removeScene(sceneName)

func addScene():
	Root.addScene()

func replaceScene(sceneToRemove:String):
	removeScene(sceneToRemove)
	addScene()

func directScene(sceneName:String):
	asyncQueue.append(Root.callSelfDirection(sceneName))

func fadeIn(duration:int = 1):
	asyncQueue.append(Overlay.fadeInBlack(duration)) # Start fade in to black and wait

func fadeOut(duration:int = 1):
	asyncQueue.append(Overlay.fadeOutBlack(duration)) # Start fade out from black and wait

func playMusic(path:String):
	Overlay.playMusic(path)
