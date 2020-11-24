extends "res://bosses/brain.gd"


export (float) var breakpoint_transform = 0.3
export (int) var chase_player_limit = 64


func _on_health_decreased(point):
	if point.decreased(breakpoint_transform):
		body.state.enter('transform')
	
	if point.decreased(0.25):
		reward(30)


func chase_player():
	var direction = GAME.player_position() - body.global_position
	if direction.length() > chase_player_limit:
		walk(direction)


func walk(direction):
	body.move_and_slide(direction.normalized() * 100)

