extends KinematicBody2D

const IS_PLAYER = true

onready var movement = $movement
onready var weapon = $weapon

onready var particles_coin_grab = $particles_coin_grab


export (int) var max_health = 3
var health
var coins = 0


func _ready():
	ROOT.player = self
	health = max_health
	

func _process(delta):
	if not GAME.player_has_been_slayed():
		$animation.animate(movement.linear_velocity)


func get_velocity():
	return movement.remaining_linear_velocity.length()


func get_weapon_scope():
	return weapon.get_scope()


func weapon_aim(direction):
	var x_scale = weapon.aim(direction)
	
	$animation.set_animation_scale(x_scale)


func weapon_shoot():
	weapon.shoot()


func grab_coin(qty = 1):
	coins += qty
	ROOT.sfx.play("coin_grab")


func hurt(damage = 1):
	health -= damage


func walk(direction, speed_scale = 1):
	movement.move(direction, speed_scale)


export (float) var tween_zoom_duration = 0.3
export (float) var time_to_fade_out = 0.8
export (float) var fadeout_duration = 0.2

onready var tween = SH.tween(self)
onready var timer_fade_out = SH.timer(self, 1, 'timeout_fade_out', true)

var death_duration
func _on_slayed(death_duration):
	self.death_duration = death_duration
	weapon.drop_weapon()
	#$animation/AnimatedSprite.speed_scale = GAME.time().normalize(0.14)
	$animation/AnimatedSprite.play('death')
	
	GAME.camera().tween_zoom(3, death_duration * tween_zoom_duration)
	GAME.camera().drag_margin(0)
	
	GAME.screen_shake(0.2, 32, Tween.TRANS_QUINT)
	ROOT.gameplay.flash.flash(0.1, Tween.TRANS_LINEAR)
	
	timer_fade_out.wait_time = death_duration * time_to_fade_out
	timer_fade_out.start()


func timeout_fade_out():
	ROOT.gameplay.flash.modulate_initial = Color(0,0,0, 0)
	ROOT.gameplay.flash.modulate_final = Color(0,0,0)
	ROOT.gameplay.flash.flash(death_duration * fadeout_duration, Tween.TRANS_LINEAR)
	

