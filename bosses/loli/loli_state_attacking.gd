extends "res://statemachine/State.gd"


func _entered():
	body.attack.begin('loli_pattern')
	
	body.sprite_animation.play('attack')


func _transition():
	var is_transition_allowed = body.attack.trigger('loli_pattern')
	
	if is_transition_allowed:
		state.enter('walking')


func _exited():
	pass