extends Node


const DEFAULT_SPEED = 1000
const DEFAULT_LIFE_RANGE = 1000


onready var body = get_parent()



func get_attack(attack_node_name):
	return get_node_or_null(attack_node_name)


func begin(attack):
	attack = get_attack(attack)
	if attack:
		return attack.begin()


func trigger(attack):
	attack = get_attack(attack)
	if attack:
		return attack.trigger()


func get_body_position(offset = Vector2.ZERO):
	return body.global_position + offset


func shoot(origin, direction, speed = DEFAULT_SPEED, bullet_resource = ROOT.bullets.hostile, life_range = DEFAULT_LIFE_RANGE):
	var bullet = ROOT.gameplay.bullet_container.create(bullet_resource, origin, direction, speed, life_range)
	setup_bullet(bullet)
	return bullet


onready var timerate_sfx = SH.timerate(self, 0.23)
func setup_bullet(bullet):
	if SH.timerate_tick(timerate_sfx):
		ROOT.sfx.play('hostile_shooted')


func direction_to_player():
	return GAME.player_position() - body.global_position


func angle_to_player():
	return direction_to_player().angle()


var Scope = preload("res://bosses/Scope.tscn")
func add_scope(node):
	var scope = Scope.instance()
	scope.shooting = self
	node.add_child(scope)
	return scope


