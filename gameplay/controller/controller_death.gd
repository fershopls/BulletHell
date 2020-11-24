extends Node


export (float) var death_wait_time = 0.7
export (float) var death_time_scale = 0.2


onready var timer_death = SH.timer(self, 1, 'timeout_death', true)


var death_was_triggered = false
func trigger():
	if not death_was_triggered:
		death_was_triggered = true
		
		
		GAME.time().set_time_scale(death_time_scale, true)
		ROOT.player._on_slayed(death_wait_time)
		
		timer_death.wait_time = death_wait_time
		timer_death.start()


func player_has_been_slayed():
	return death_was_triggered


func timeout_death():
	GAME.time().set_time_scale(1, true)
	GAME.game_over()