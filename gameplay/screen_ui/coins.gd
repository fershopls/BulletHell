extends HBoxContainer


onready var label = $Label


func _process(delta):
	label.text = str(get_coins())


func get_coins():
	return ROOT.player.coins

