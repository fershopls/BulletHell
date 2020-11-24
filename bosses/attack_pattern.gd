extends Node

onready var attack = get_parent()


func _ready():
	pass


func begin():
	pass


func trigger():
	pass


func is_under_health(health):
	return attack.body.is_under_health(health)


func new_scope():
	return attack.add_scope(self)
