extends Control

func self_direction():
	yield(Director.wait(2), "completed")
	#$"Animator".play("SplashLogo1FadeOut")
	#yield($"Animator", "animation_finished")
