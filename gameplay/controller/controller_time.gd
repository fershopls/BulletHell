extends Node


export (float) var time_scale_normal = 1
var time_scale = 1


func _process(delta):
	Engine.time_scale = time_scale


func get_normal_time(wait_time):
	return wait_time * time_scale


func set_time_scale(time_scale, force = false):
	if self.time_scale == 1 or force:
		self.time_scale = time_scale


func restore_time_scale(time_scale_registered):
	if time_scale == time_scale_registered:
		self.time_scale = time_scale_normal