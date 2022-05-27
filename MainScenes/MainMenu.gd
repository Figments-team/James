extends Control

func self_direction():
	$"MenuAnimator".play("MenuFadeIn")
	yield($"MenuAnimator", "animation_finished")
	$"LabelAnimator".play("PressAnyKeyFade")
