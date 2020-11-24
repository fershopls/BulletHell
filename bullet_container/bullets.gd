extends Node

var default = preload("res://bullet/default.tscn")
var hostile = preload("res://bullet/hostile.tscn")


var sprites = {
	'hostile': preload("res://sprites/bullets/hostile.png"),
	'hostile_blue': preload("res://sprites/bullets/hostile_blue.png"),
}

func _ready():
	ROOT.bullets = self