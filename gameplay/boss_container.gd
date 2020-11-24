extends Node

onready var gameplay = get_parent()


var loli = preload("res://bosses/loli/loli.tscn")
var heart = preload("res://bosses/heart/heart.tscn")

func create(boss_resource):
	var boss = boss_resource.instance()
	boss.position = $spawn.global_position
	add_child(boss)
	return boss
