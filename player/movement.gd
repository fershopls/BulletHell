extends Node

onready var body = get_parent()


export (int) var pixels_per_second = 220

var linear_velocity = Vector2.ZERO
var remaining_linear_velocity = linear_velocity
func _process(delta):
	remaining_linear_velocity = body.move_and_slide(linear_velocity)
	linear_velocity = Vector2.ZERO


func move(direction, speed_scale = 1):
	linear_velocity = direction.normalized() * pixels_per_second * speed_scale
