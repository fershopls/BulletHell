extends Node2D


onready var animated_sprite = $AnimatedSprite


func _ready():
	animated_sprite.connect("animation_finished", self, "_on_animation_finished")


func play(animation_name):
	_current_animation = animation_name
	animated_sprite.play(animation_name)
	animated_sprite.frame = 0


var _current_animation
var _queued_animation
func queue(animation_name):
	_queued_animation = animation_name


func _on_animation_finished():
	if _queued_animation:
		play(_queued_animation)
		_queued_animation = null
	else:
		play(_current_animation)