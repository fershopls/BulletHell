extends KinematicBody2D

const IS_BOSS = true


onready var state = $statemachine
onready var brain = $brain
onready var attack = $attack
onready var health_breakpoints = $health_breakpoints


onready var sprite_animation = $sprite_animation
onready var sprite_flicker = $sprite_animation/sprite_flicker


export (int) var max_health = 300
var health


func _ready():
	health = max_health
	health_breakpoints.connect("health_decreased", brain, "_on_health_decreased")


func get_health_percent():
	return float(health) / float(max_health)


func is_under_health(health):
	return get_health_percent() <= health
	

signal damaged
func hurt(qty):
	health -= qty
	emit_signal("damaged", qty)
	sprite_flicker.flick()


func destroy():
	state.enter("dying")
