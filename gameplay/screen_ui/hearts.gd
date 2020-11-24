extends Node

var RSC_HEART = preload("res://gameplay/screen_ui/heart.tscn")


var hearts = []


func get_max_health():
	return ROOT.player.max_health

func get_health():
	return ROOT.player.health


func _ready():
	update_max_health()


func update_max_health():
	for child in get_children():
		child.free()
	
	hearts = []
	for i in range(get_max_health()):
		hearts.append(add_heart())


func _process(delta):
	update_hearts_status()



func update_hearts_status():
	var health = get_health()
	
	var i = 0
	for heart in hearts:
		i += 1
		if i <= health:
			heart.dead = false
		else:
			heart.dead = true
	

func add_heart():
	var heart = RSC_HEART.instance()
	add_child(heart)
	return heart
	