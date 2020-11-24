extends "res://statemachine/State.gd"


export (float) var free_wait_time = 2.3

onready var timer_free = SH.timer(self, free_wait_time, 'timeout_free')

var RSC = preload("res://particles/boss_death.tscn")
func _entered():
	ROOT.gameplay.bullet_container.clear()
	GAME.screen_shake(free_wait_time, 64, Tween.TRANS_SINE, Tween.EASE_OUT)
	timer_free.start()
	
	
	var particles = RSC.instance()
	body.add_child(particles)
	
	GAME.camera().look_at_boss()
	
	ROOT.controller.player.is_shoot_allowed = false
	
	

var i = 1
onready var timerate_flick = SH.timerate(self, 0.1)
func _transition():
	if not SH.timerate_tick(timerate_flick):
		return
	
	i *= -1
	
	if i == -1:
		body.sprite_animation.modulate = Color()
	else:
		var x = 15
		body.sprite_animation.modulate = Color(x,x,x)


func timeout_free():
	_exited()


func _exited():
	ROOT.controller.player.is_shoot_allowed = true
	ROOT.controller.boss.instance()
	GAME.camera().look_at_player()
	body.call_deferred("free")