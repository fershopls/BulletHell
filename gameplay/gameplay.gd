extends Node


onready var bullet_container = $bullet_container
onready var object_container = $object_container
onready var boss_container = $boss_container


onready var collision = $collision
onready var camera = $camera
onready var gui = $gui


onready var flash = $gameplay_flash


func _ready():
	ROOT.gameplay = self
	camera.following_node = $player


func get_boss():
	var current_boss = ROOT.controller.boss.get_boss()
	if is_instance_valid(current_boss):
		return current_boss
	return false

func get_boss_position():
	if get_boss():
		return get_boss().global_position


func _process(delta):
	show_boss_health()


func show_boss_health():
	if get_boss():
		gui.update_boss_health(get_boss().get_health_percent())
	else:
		gui.update_boss_health(null)


func hurt_boss(damage = 1):
	var current_boss = get_boss()
	if not current_boss:
		return
	
	current_boss.hurt(damage)
	
	if current_boss.health <= 0:
		current_boss.destroy()
		current_boss = null


func hurt_player():
	if GAME.player_has_been_slayed():
		return
	
	flash.flash()
	GAME.screen_shake(0.5, 32)
	ROOT.player.hurt()
	bullet_container.clear_range(GAME.player_position(), 88)
	
	if ROOT.player.health <= 0:
		ROOT.controller.death.trigger()

