extends Node


export (float) var firerate = 0.1


onready var interval = SH.timerate(self, firerate)

func _process(delta):
	var boss_position = ROOT.gameplay.get_boss_position()
	if not boss_position:
		return
	
	var direction = boss_position - GAME.player_position()
	var liferange = 180
	var shoot_range = liferange + 88
	ROOT.player.weapon_aim(direction)
	
	if direction.length() > shoot_range:
		return
	
	if SH.timerate_tick(interval):
		var speed = 450
		var max_bloom = deg2rad(15)
		var bloom_randomness = 0.5
		
		if ROOT.player.get_velocity() > 0:
			max_bloom = deg2rad(90)
			bloom_randomness = 1
		
		direction = SH.rad2vec(RNG.bloom(direction.angle(), max_bloom, bloom_randomness))
		ROOT.controller.player.shoot(direction, liferange, speed)
		
