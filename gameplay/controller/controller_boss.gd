extends Node


var boss


var all_bosses = {
	'loli': preload("res://bosses/loli/loli.tscn"),
	'heart': preload("res://bosses/heart/heart.tscn"),
}


var sequence = []
func _ready():
	sequence = [
		all_bosses.loli,
		all_bosses.heart
	]
	call_deferred('instance')


func get_boss():
	return boss


func instance():
	if not sequence.size():
		print(0)
		return
	
	var boss = sequence[0]
	self.boss = ROOT.gameplay.boss_container.create(boss)
	sequence.pop_front()
