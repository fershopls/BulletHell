extends Node

onready var input = get_parent()

export (float) var sensitivity = 1.4
export (int) var hint_deathzone = 3


onready var hint = $movement_hint
var hint_position


func _ready():
	clear()


func _process(delta):
	if not hint.visible:
		return
	
	hint.global_position = hint_position
	var hint_direction = hint_position - GAME.player_position()
	
	if hint_direction.length() > hint_deathzone:
		input.move(hint_direction)


func drag (difference):
	hint_position += difference * sensitivity


func clear():
	hint_position = GAME.player_position()
	current_drag_position = Vector2.ZERO
	last_drag_position = Vector2.ZERO


var current_drag_position
var last_drag_position
func _input(event):
	if event is InputEventScreenDrag or event is InputEventMouseMotion:
		var difference = Vector2.ZERO
		
		if last_drag_position.length():
			last_drag_position = current_drag_position
			current_drag_position = event.position
			difference = current_drag_position - last_drag_position
		else:
			last_drag_position = current_drag_position
			current_drag_position = event.position
		
		drag(difference)
	
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		if event.pressed:
			hint.visible = true
			time_restore()
		else:
			hint.visible = false
			time_slowdown()
		clear()


export (float) var time_scale_slow = 0.1

func time_restore():
	GAME.time().restore_time_scale(time_scale_slow)

func time_slowdown():
	GAME.time().set_time_scale(time_scale_slow)
