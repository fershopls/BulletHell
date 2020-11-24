extends KinematicBody2D

const IS_BULLET = true


var origin
var direction
var speed setget set_speed
var liferange

export (NodePath) var sprite

export (bool) var speed_boost_enabled = false
export (int) var speed_boost_scale = 3
export (int) var speed_boost_range = 64


export (bool) var rotate_towards_direction = true


onready var timer_free = SH.timer(self, 1, 'timeout_free', true)

func _ready():
	direction = direction.normalized()
	global_position = origin
	
	if rotate_towards_direction:
		global_rotation = direction.angle()
	
	setup_free_timer()

func setup_free_timer():
	timer_free.wait_time = float(liferange) / float(speed)
	timer_free.wait_time = min(timer_free.wait_time, 20)
	timer_free.start()


func set_speed(value):
	speed = value
	call_deferred("setup_free_timer")


func get_speed():
	if speed_boost_enabled:
		if (global_position - origin).length() < speed_boost_range:
			return speed * speed_boost_scale
		else:
			speed_boost_enabled = false
	return speed


func _process(delta):
	var collision = move_and_collide(direction * get_speed() * delta)
	if collision:
		report_collision(collision)


func report_collision(collision):
	ROOT.gameplay.collision.report_bullet(self, collision.collider)
	destroy()



func timeout_free():
	destroy()


func update_sprite(texture):
	if sprite:
		get_node(sprite).texture = texture


func destroy():
	call_deferred("free")