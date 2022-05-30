extends CanvasLayer

func showLoader():
	$"Loading".visible = true

func hideLoader():
	$"Loading".visible = false

func cutInBlack():
	$"BlackPanel".modulate.a = 255

func cutOutBlack():
	$"BlackPanel".modulate.a = 0

func fadeInBlack(duration:int = 1):
	var speed = 1.0 / duration
	$"BlackPanel".visible = true
	$"PanelAnimator".play("FadeInBlack", -1, speed)
	yield($"PanelAnimator", "animation_finished")

func fadeOutBlack(duration:int = 1):
	var speed = 1.0 / duration
	$"PanelAnimator".play("FadeOutBlack", -1, speed)
	yield($"PanelAnimator", "animation_finished")
	$"BlackPanel".visible = false

func playMusic(path:String, looped:bool = false):
	$"MusicPlayer".stream = load(path)
	$"MusicPlayer".play()
