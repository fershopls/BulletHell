extends Node


func create (resource, origin, direction, speed, liferange = 50):
	var bullet = resource.instance()
	bullet.origin = origin
	bullet.direction = direction
	bullet.speed = speed
	bullet.liferange = liferange
	add_child(bullet)
	return bullet

func clear():
	for bullet in get_children():
		bullet.destroy()


func clear_range(position, radius):
	for bullet in get_children():
		var length = (position - bullet.global_position).length()
		if length < radius:
			bullet.destroy()

