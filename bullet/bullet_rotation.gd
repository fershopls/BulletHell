extends Node2D


var rotation_direction
export (float) var rads_per_second = PI * 4
export (float) var rads_per_second_randomness = 0.8
func _ready():
	rotation = RNG.angle()
	rotation_direction = RNG.sign()
	
	if rads_per_second_randomness:
		rads_per_second = RNG.randomness(rads_per_second, rads_per_second_randomness)


func _process(delta):
	rotation += delta * rads_per_second * rotation_direction