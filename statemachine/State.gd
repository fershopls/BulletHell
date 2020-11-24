extends Node

const IS_STATE = true

var state
var body

func _ready():
	state = get_parent()
	body = state.get_parent()


func _entered():
	pass

func _transition():
	pass

func _exited():
	pass