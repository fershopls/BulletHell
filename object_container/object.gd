extends Node2D


export (float) var ease_throw = 0.1
export (float) var ease_grab = 0.1


var origin = Vector2.ZERO
var direction = Vector2.UP
var throw_distance = 100
var duration = Vector2.ZERO

var _target


onready var timer_throw = SH.timerate(self, 1)

func _ready():
	direction = direction.normalized()
	global_position = origin
	_target = origin + direction * throw_distance
	
	timer_throw.wait_time = duration
	timer_throw.start()


func _process(delta):
	if not timer_throw.is_stopped():
		process_throw()
	else:
		process_grab()

var elapsed_throw = 0
var elapsed_grab = 0


var throw_end_position = Vector2.ZERO
func process_throw():
	elapsed_throw += get_process_delta_time()
	
	var percent = elapsed_throw / duration
	percent = min(1, percent)
	
	var _ease = ease(percent, ease_throw)
	
	position  = lerp(origin, _target, _ease)
	throw_end_position = position


func process_grab():
	elapsed_grab += get_process_delta_time()
	
	var percent = elapsed_grab / duration
	percent = min(1, percent)
	
	var _ease = ease(percent, ease_grab)
	
	position = lerp(throw_end_position, GAME.player_position(), _ease)
	
	if _ease >= 0.9:
		report_grab()


func report_grab():
	ROOT.controller.object.grab(self)
	destroy()


func destroy():
	call_deferred("free")