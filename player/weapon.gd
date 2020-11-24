extends Node2D

onready var sprite_weapon = $sprite_weapon
onready var sprite_effect = $sprite_effect


func aim(direction):
	var x_scale = 1
	if direction.x < 0:
		x_scale = -1
	
	scale.y = x_scale
	
	global_rotation = direction.angle()
	
	return x_scale


onready var timerate_shoot = SH.timerate(self)
func shoot():
	#return
	sprite_effect.flip_v = RNG.chance(0.5)
	sprite_effect.play("default")
	sprite_effect.frame = 0

func drop_weapon():
	sprite_weapon.position.y = 17.2
	show_behind_parent = true


func get_scope():
	return $scope.global_position