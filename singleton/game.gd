extends Node


func game_over():
	get_tree().change_scene("res://screen/die/screen_die.tscn")


func screen_shake(duration, force = 32, tween_trans = Tween.TRANS_SINE, tween_ease = Tween.EASE_OUT):
	ROOT.gameplay.camera.camera_shaker.shake(duration, force, tween_trans, tween_ease)


func player_position():
	return ROOT.player.global_position


func player_has_been_slayed():
	return ROOT.controller.death.player_has_been_slayed()


func camera():
	return ROOT.gameplay.camera


func time(convert_to_normal_time = null):
	if convert_to_normal_time == null:
		return ROOT.controller.time
	
	return convert_to_normal_time * time().time_scale


func is_player(node):
	var constant = 'IS_PLAYER'
	return node.get(constant) == true

func is_boss(node):
	var constant = 'IS_BOSS'
	return node.get(constant) == true