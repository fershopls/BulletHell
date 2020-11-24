extends Node


func create (resource, origin, throw_distance, duration, direction):
	var object = resource.instance()
	object.origin = origin
	object.direction = direction
	object.throw_distance = throw_distance
	object.duration = duration
	add_child(object)
	return object

