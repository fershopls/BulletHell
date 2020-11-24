extends Node

var angle = 0
var speed = 1
var origin = null
var firerate = 0.3
var circle_divisor = 32
var speed_scale = 1
export (Resource) var sprite_resource


func get_slices(i = 1, slices = circle_divisor):
	return SH.slice_circle(slices) * i


func get_direction(angle, distance):
	return SH.rad2vec(angle) * distance


func get_body_position():
	return shooting.get_body_position()


func aim_at_player(offset_slices = 0):
	var offset = get_slices(offset_slices)
	angle = shooting.angle_to_player() + offset


func clear():
	times = 0

func single(origin_distance = 0, offset_slices = 0):
	var _angle = angle + get_slices(offset_slices)
	var _origin = _get_origin() + get_direction(_angle, origin_distance)
	_shoot(_angle, _origin)



var shooting
onready var timerate_firerate = SH.timerate(self, firerate)


func rotate(slices = 1):
	angle += get_slices(slices)


func _shoot(angle, origin = _get_origin()):
	var bullet = shooting.shoot(origin, SH.rad2vec(angle))
	bullet.speed = _get_speed()
	if sprite_resource:
		bullet.update_sprite(sprite_resource)


func circle(slices, radius, circle_angle = null, offset_slices = 0):
	var offset = get_slices(offset_slices)
	
	for i in range(slices):
		var slice_angle = angle + get_slices(i, slices) + offset
		var origin_offset = get_direction(slice_angle, radius)
	
		var bullet_angle = slice_angle
		if circle_angle:
			bullet_angle = circle_angle
		
		_shoot(bullet_angle, _get_origin(origin_offset))


func _get_origin(offset = Vector2.ZERO):
	if origin == null:
		return get_body_position() + offset
	else:
		return origin + offset


func _get_speed():
	return speed * speed_scale


#
# Times
#
var times = 0

func is_shoot_allowed():
	if SH.timerate_tick(timerate_firerate, firerate):
		times += 1
		return true
	return false


func times_clear():
	times = 0


func times_each(i):
	return times % i == i - 1


func times_looped(i):
	return times / i


func times_reached(i):
	return times >= i