extends Node


onready var tween = SH.tween(self)
onready var polygon = $Polygon2D


export (Color) var modulate_initial = Color(1,1,1)
export (Color) var modulate_final = Color(1,1,1,0)


func _ready():
	polygon.visible = true
	polygon.modulate = modulate_final


func flash(duration = 0.6, tween_trans = Tween.TRANS_CUBIC, tween_ease = Tween.EASE_OUT):
	tween.stop_all()
	tween.interpolate_property(polygon, 'modulate', modulate_initial, modulate_final, duration, tween_trans, tween_ease)
	tween.start()