extends Node


func timer(node, wait_time = 1, timeout = null, one_shoot = false, autostart = false):
	var timer = Timer.new()
	timer.wait_time = wait_time
	timer.one_shot = one_shoot
	timer.autostart = autostart
	if timeout:
		timer.connect('timeout', node, timeout)
	node.add_child(timer)
	return timer


func timerate(node, wait_time = 1):
	return timer(node, wait_time, null, true)


func timerate_tick(timer, wait_time = null):
	if timer.is_stopped():
		if wait_time:
			timer.wait_time = wait_time
		timer.start()
		return true
	else:
		return false


func tween(node, completed = null):
	var tween = Tween.new()
	if completed:
		tween.connect('tween_completed', node, completed)
	node.add_child(tween)
	return tween


func rad2vec(angle):
	return Vector2(cos(angle), sin(angle)).normalized()



func slice_circle(slices):
	return 2 * PI / slices
	

func lerp_rotation (from, to, rads_per_second = 2 * PI):
	var difference = to - from
	var lerp_direction = 1
	
	if difference < 0:
		lerp_direction *= -1
	
	if abs(difference) >= PI:
		lerp_direction *= -1
	
	var angle_lerp = rads_per_second * get_process_delta_time()
	if abs(angle_lerp) > abs(difference):
		return float(to)
	else:
		return float(from + angle_lerp * lerp_direction)