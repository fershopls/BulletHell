extends Node

func rng(unit = 1):
	return randf() * unit

func sign():
	if chance(0.5):
		return 1
	else:
		return -1

func angle():
	return PI * 2 * randf()

func item(items):
	var rng = rng()
	for item in items:
		if rng <= item[0]:
			return item[1]

func choose(list):
	return list[randi()%list.size()]

func chance(percent, rng = randf()):
	return rng <= percent


func randomness(value, randomness):
	randomness = min(1, abs(randomness))
	return value - value * rng(randomness)


func bloom(angle, max_bloom, bloom_randomness = 0):
	if bloom_randomness:
		max_bloom = RNG.randomness(max_bloom, bloom_randomness)
	return angle - max_bloom / 2 + RNG.rng(max_bloom)