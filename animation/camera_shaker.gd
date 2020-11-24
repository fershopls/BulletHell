extends Node


onready var camera = get_parent()
onready var tween = SH.tween(self, 'tween_completed')

var shake_amount = 1.0

func _process(delta):
	if tween.is_active():
		var offset = Vector2(rand_range(-1.0, 1.0) * shake_amount, rand_range(-1.0, 1.0) * shake_amount)
		camera.offset = offset 
	else:
		camera.offset = Vector2.ZERO


func shake(duration, force = 32, tween_trans = Tween.TRANS_SINE, tween_ease = Tween.EASE_OUT):
	_times = 0
	tween.stop_all()
	tween.interpolate_property(self, 'shake_amount', force, 0, duration, tween_trans, tween_ease)
	tween.start()

var _duration
var _times
var _force
var _angle
func knockback(duration = 0.15, times = 2, force = 32, predefined_angle = null):
	var initial = get_initial_position(get_angle(predefined_angle), force)
	var final = Vector2.ZERO
	var tween_duration = float(duration) / float(times)
	tween.stop_all()
	tween.interpolate_property(camera, 'offset', initial, final, tween_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	
	_duration = duration
	_times = times - 1
	_force = force
	_angle = predefined_angle


func tween_completed(object, key):
	if _times > 0:
		knockback(_duration, _times, _force, _angle)


func get_initial_position(angle, force):
	return SH.rad2vec(angle) * force


func get_angle(angle):
	if angle == null:
		return RNG.angle()
	return angle