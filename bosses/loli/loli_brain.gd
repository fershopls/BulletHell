extends "res://bosses/brain.gd"

export (int) var chase_player_limit = 64

# Loli Brain
func chase_player():
	var direction = GAME.player_position() - body.global_position
	if direction.length() > chase_player_limit:
		move(direction)


func _on_health_decreased(points):
	
	if points.decreased(0.75):
		reward(10)
	
	if points.decreased(0.70):
		explode()
	
	if points.decreased(0.5):
		reward(10)
	
	if points.decreased(0.45):
		explode()
	
	if points.decreased(0.25):
		reward(10)
	
	if points.decreased(0.1):
		explode()
	


func explode():
	body.attack.trigger('explode_pattern')
	GAME.screen_shake(0.8)

