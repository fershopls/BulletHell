extends Node


onready var body = get_parent()

export (int) var pixels_per_second = 100


func move(direction):
	body.move_and_slide(direction.normalized() * pixels_per_second)


func reward(ammount, health_multiplier = true, screen_shake = true):
	if health_multiplier:
		ammount *= ROOT.player.health
	ROOT.controller.object.throw(body.global_position, ammount)
	if screen_shake:
		GAME.screen_shake(0.4, 16)