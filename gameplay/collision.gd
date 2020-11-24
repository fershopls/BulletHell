extends Node

onready var gameplay = get_parent()

func report_bullet (bullet, body):
	if GAME.is_player(body):
		gameplay.hurt_player()
	
	elif GAME.is_boss(body):
		gameplay.hurt_boss()
		ROOT.sfx.play("player_hit")