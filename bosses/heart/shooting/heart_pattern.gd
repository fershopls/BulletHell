extends "res://bosses/attack_pattern.gd"

var origin_distance = 32

var snail
var star
func _ready():
	star = new_scope()
	star.circle_divisor = 32
	
	snail = new_scope()
	snail.firerate = 0.04
	snail.speed = 160
	snail.circle_divisor = 32
	snail.sprite_resource = ROOT.bullets.sprites.hostile_blue


func begin():
	# Begin
	snail.aim_at_player(-8)
	snail.clear()
	
	star.aim_at_player()
	star.clear()


func trigger():
	var snail = snail()
	var explode = explode()
	return snail and explode


func snail():
	if not is_under_health(0.75):
		return true
	
	var cycles = 1	
	if is_under_health(0.5):
		cycles = 2
	
	if snail.times_looped(16) == cycles:
		return true
	
	# Trigger
	if snail.is_shoot_allowed():
		if is_under_health(0.5):
			snail.single(origin_distance, -16.5)
		
		snail.single(origin_distance)
		snail.rotate()


func explode():
	if star.times_reached(1):
		return true
	
	if not star.is_shoot_allowed():
		return false
	
	if is_under_health(0.25):
		star.speed = 240
		star.circle(4, origin_distance)
		star.speed = 200
		star.circle(4, origin_distance)
	
	star.speed = 80
	star.circle(32, origin_distance + 32, null)

	star.speed = 80
	star.circle(16, origin_distance, null, 0.5)
	
	star.speed = 120
	star.circle(4, 0)
