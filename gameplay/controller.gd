extends Node

onready var player = $player
onready var object = $object
onready var death = $death
onready var time = $time
onready var boss = $boss


func _ready():
	ROOT.controller = self