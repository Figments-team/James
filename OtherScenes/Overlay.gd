extends CanvasLayer

onready var Loading = $"Loading"
onready var Animator = $"PanelAnimator"
signal fade_finished

func showLoader():
	Loading.visible = true

func hideLoader():
	Loading.visible = false

func fadeInBlack():
	Animator.play("BlackPanelFadeIn")
	yield(Animator, "animation_finished")
	emit_signal("fade_finished")

func fadeOutBlack():
	Animator.play("BlackPanelFadeOut")
	yield(Animator, "animation_finished")
	emit_signal("fade_finished")
