extends "res://statemachine/State.gd"


export (float) var min_state_time = 2
export (float) var state_think_time = 0.25

var damage_taken = 0
var think_interval = SH.timerate(self)
var chasing_player


func _ready():
	body.connect('damaged', self, '_on_damaged')


func _entered():
	chasing_player = RNG.chance(0.5)
	damage_taken = 0
	SH.timerate_tick(think_interval, min_state_time)
	body.sprite_animation.queue('idle')
	

func _on_damaged(damage):
	damage_taken += damage


func _transition():
	if chasing_player:
		body.brain.chase_player()
	
	if SH.timerate_tick(think_interval, state_think_time):
		if RNG.chance(0.8):
			chasing_player = true
		
		if damage_taken > 15 or RNG.chance(0.35):
			return state.enter('attacking')
	


func _exited():
	pass