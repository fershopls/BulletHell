extends Node


func move(direction, speed_scale = 1):
	ROOT.controller.player.move(direction, speed_scale)