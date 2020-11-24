extends Node

export (bool) var is_shoot_allowed = true


func move(direction, speed_scale):
	if GAME.player_has_been_slayed():
		return
	
	ROOT.player.walk(direction, speed_scale)


func shoot(direction, liferange, speed):
	if GAME.player_has_been_slayed() or not is_shoot_allowed:
		return
	
	var origin = ROOT.player.get_weapon_scope()
	ROOT.gameplay.bullet_container.create(ROOT.bullets.default, origin, direction, speed, liferange)
	ROOT.player.weapon_shoot()
	ROOT.sfx.play("player_shoot")