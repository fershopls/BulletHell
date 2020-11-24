extends "res://bosses/attack_pattern.gd"


var star
func _ready():
	star = new_scope()
	star.speed = 180
	star.circle_divisor = 12
	star.sprite_resource = ROOT.bullets.sprites.hostile_blue


func begin():
	star.clear()


func trigger():
	star.aim_at_player()
	#var origin_offset_distance = 64
	#star.origin = star.get_body_position() + star.get_direction(star.angle, origin_offset_distance)
	star.circle(star.circle_divisor, 48)
	return true