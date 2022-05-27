extends CanvasLayer

func showLoader():
	$"Loading".visible = true

func hideLoader():
	$"Loading".visible = false

func fadeInBlack():
	$"BlackPanel".visible = true
	$"PanelAnimator".play("BlackPanelFadeIn")
	yield($"PanelAnimator", "animation_finished")

func fadeOutBlack():
	$"PanelAnimator".play("BlackPanelFadeOut")
	yield($"PanelAnimator", "animation_finished")
	$"BlackPanel".visible = false

func playMusic(path:String, looped:bool = false):
	$"MusicPlayer".stream = load(path)
	$"MusicPlayer".play()
