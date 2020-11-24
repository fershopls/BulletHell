extends "res://bosses/attack_pattern.gd"


var smg
func _ready():
	smg = new_scope()
	smg.firerate = 0.3
	smg.speed = 200
	# smg.sprite_resource = ROOT.bullets.sprites.hostile_blue


func begin():
	smg.clear()


func trigger():
	var bullets
	
	if is_under_health(0.45):
		bullets = 12
	elif is_under_health(0.75):
		bullets = 6
	else:
		bullets = 3
	
	if smg.times_reached(bullets):
		return true
	
	if smg.is_shoot_allowed():
		smg.aim_at_player()
		# smg.speed_scale = max(1, RNG.randomness(2, 0.5))
		smg.angle = RNG.bloom(smg.angle, deg2rad(90), 0.8)
		smg.single(32)