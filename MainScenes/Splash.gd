extends Control

func self_direction():
	yield(Director.wait(2), "timeout")
	#$"Animator".play("SplashLogo1FadeOut")
	#yield($"Animator", "animation_finished")
