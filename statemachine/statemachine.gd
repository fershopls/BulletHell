extends Node

onready var parent = get_parent()

var current_state
# Setted whenever current_state is exited
var previous_state

export (NodePath) var initial_state
export (bool) var initial_call_deferred = false


func _ready():
	if initial_state:
		var node = get_node(initial_state)
		if initial_call_deferred:
			call_deferred("_enter_state_node", node)
		else:
			_enter_state_node(node)


func enter_random(choices):
	enter(RNG.choose(choices))

func enter(state_key):
	var state_node = _find_state_node_by_state_key(state_key)
	if state_node:
		_enter_state_node(state_node)


func _enter_state_node(state_node):
	if current_state == state_node:
		return
	if current_state:
		_exit_state_node(current_state)
	current_state = state_node
	current_state.call('_entered')


func _exit_state_node(state_node):
	if current_state == state_node:
		current_state = null
		state_node.call('_exited')
		previous_state = state_node


func _process(delta):
	if current_state:
		current_state.call('_transition')


func _find_state_node_by_state_key(state_key):
	var state_node =  get_node_or_null('state_' + state_key)
	if state_node and state_node.get('IS_STATE'):
		return state_node
	return null