extends "res://statemachine/State.gd"

var time_scale = 0.4

func _entered():
	body.sprite_animation.play('transform')
	body.sprite_animation.queue('idle2')
	GAME.camera().look_at_boss()
	ROOT.gameplay.bullet_container.clear()
	GAME.screen_shake(1, 32)
	
	GAME.time().set_time_scale(time_scale)


func _transition():
	var is_transition_allowed = not body.sprite_animation.get_animation_name() == 'transform'
	
	if is_transition_allowed:
		state.enter('walking')
	


func _exited():
	GAME.camera().look_at_player()
	GAME.time().restore_time_scale(time_scale)
