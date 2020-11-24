extends "res://statemachine/State.gd"


func _entered():
	body.attack.begin('heart_pattern')
	
	if body.is_under_health(body.brain.breakpoint_transform):
		body.sprite_animation.play('attack2')
	else:
		body.sprite_animation.play('attack')


func _transition():
	var is_transition_allowed = body.attack.trigger('heart_pattern')
	
	if is_transition_allowed:
		state.enter('walking')
	


func _exited():
	pass
