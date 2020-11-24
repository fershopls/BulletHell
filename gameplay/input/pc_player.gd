extends Node

onready var input = get_parent()


var time = 0
var last_direction = Vector2.ZERO
var current_direction = Vector2.ZERO


export (float) var speed_scale_threshold = 0.200


onready var timer_speed_threshold = SH.timerate(self, speed_scale_threshold)
func _process(delta):
	last_direction = current_direction
	current_direction = get_input_direction()
	
	if timer_speed_threshold.is_stopped():
		input.move(current_direction)
	else:
		input.move(current_direction, 0.5)
	
	if not last_direction.length() and current_direction.length():
		time = OS.get_system_time_msecs()
		#print ("Start moving")
		timer_speed_threshold.start()
	elif last_direction != Vector2.ZERO and current_direction == Vector2.ZERO:
		var _time = OS.get_system_time_msecs() - time
		#print ('Moved for: ', _time)

func get_input_direction():
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	
	return direction