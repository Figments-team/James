extends CanvasLayer

onready var Loading = $"Loading"
onready var Animator = $"PanelAnimator"
onready var BlackPanel = $"BlackPanel"
onready var MusicPlayer = $"MusicPlayer"

func showLoader():
	Loading.visible = true

func hideLoader():
	Loading.visible = false

func fadeInBlack():
	BlackPanel.visible = true
	Animator.play("BlackPanelFadeIn")
	yield(Animator, "animation_finished")

func fadeOutBlack():
	Animator.play("BlackPanelFadeOut")
	yield(Animator, "animation_finished")
	BlackPanel.visible = false

func playMusic(path, looped = false):
	MusicPlayer.stream = load(path)
	MusicPlayer.play()
