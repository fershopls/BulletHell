extends Node2D

onready var sprite

export (bool) var enable_scaling = true
export (bool) var use_default_animated_sprite = true
export (int) var min_velocity_run = 90

func _ready():
	if use_default_animated_sprite:
		 sprite = $AnimatedSprite

func animate(linear_velocity):
	var velocity = linear_velocity.length()
	play_animation(velocity)
	if enable_scaling and velocity:
		set_direction(linear_velocity.x)

func set_direction(velocity_x):
	if velocity_x >= 0:
		set_animation_scale(1)
	else:
		set_animation_scale(-1)

func set_animation_scale(scale_x):
	if scale_x:
		scale.x = scale_x

func play_animation(velocity):
	if velocity >= min_velocity_run:
		run()
	else:
		idle()

func run():
	sprite.play('run')

func idle():
	sprite.play('idle')