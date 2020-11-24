extends Node


onready var body = get_parent()


signal health_decreased

var last_health_percent = 1
var health_percent = 1


func _ready():
	body.connect('damaged', self, '_on_damaged')


func _on_damaged(qty):
	last_health_percent = health_percent
	health_percent = body.get_health_percent()
	
	emit_signal("health_decreased", self)


func decreased(health_breakpoint):
	return health_percent <= health_breakpoint and last_health_percent > health_breakpoint