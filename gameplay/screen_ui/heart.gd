extends Control

var dead = false

onready var animated_sprite = $animated_sprite

func _process(delta):
	if dead:
		animated_sprite.play("dead")
	else:
		animated_sprite.play("default")