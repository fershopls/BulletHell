extends Node2D

onready var input = get_parent()


export (bool) var enabled = false
export (int) var hint_deathzone = 4
onready var hint = $movement_hint


func _process(delta):
	if not enabled or not hint.visible:
		return
	
	hint.global_position = get_global_mouse_position()
	var hint_direction = hint.global_position - GAME.player_position()
	
	if hint_direction.length() > hint_deathzone:
		input.move(hint_direction)


func _input(event):
	if not enabled:
		return
	
	if event is InputEventMouseButton:
		if event.pressed:
			hint.visible = true
		else:
			hint.visible = false
	