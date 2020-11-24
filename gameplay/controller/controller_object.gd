extends Node



func throw(origin, ammount = 1):
	var duration = RNG.randomness(2, 0.5)
	var duration_fact = max(0.8, 0.2 * ammount / 10) / ammount
	for i in range(ammount):
		# duration_fact = max(0.05, duration_fact * 0.8)
		var duration_offset = min(i, 30) * duration_fact
		
		var throw_distance = RNG.randomness(450, 0.8)
		var direction = SH.rad2vec(RNG.angle())
		var _duration = duration + duration_offset
		
		ROOT.gameplay.object_container.create(ROOT.objects.coin, origin, throw_distance, _duration, direction)


func grab(coin):
	ROOT.player.grab_coin()

