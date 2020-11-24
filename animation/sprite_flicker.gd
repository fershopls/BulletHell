extends Node

onready var sprite = get_parent()
onready var tween = SH.tween(self, '_on_tween_completed')

export (bool) var autostart = false
export (Color) var color_initial = Color(1,1,1)
export (Color) var color_flicker = Color(15,15,15)
export (float) var flick_duration = 0.2
export (bool) var loop_flick = false

func _ready():
	if autostart:
		flick()


func flick():
	tween.interpolate_property(sprite, 'modulate', color_flicker, color_initial, flick_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()


func _on_tween_completed(object, key):
	if loop_flick:
		flick()