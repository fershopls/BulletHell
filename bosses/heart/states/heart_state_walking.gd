extends "res://statemachine/State.gd"


export (float) var min_state_time = 2
export (float) var state_think_time = 0.5

var damage_taken = 0
var think_interval = SH.timerate(self)
var chasing_player

func _ready():
	body.connect('damaged', self, '_on_damaged')

func _entered():
	damage_taken = 0
	SH.timerate_tick(think_interval, min_state_time)
	chasing_player = false
	
	if body.is_under_health(body.brain.breakpoint_transform):
		body.sprite_animation.queue('idle2')
	else:
		body.sprite_animation.queue('idle')

func _on_damaged(damage):
	damage_taken += damage

func _transition():
	if chasing_player:
		body.brain.chase_player()
	
	if SH.timerate_tick(think_interval, state_think_time):
		if RNG.chance(0.5):
			chasing_player = !chasing_player
		
		if damage_taken > 25 or RNG.chance(0.1):
			return state.enter('attacking')
	


func _exited():
	pass
