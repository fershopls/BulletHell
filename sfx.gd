extends Node

export (bool) var muted = false

func _ready():
	ROOT.sfx = self

func play(key, pitch_scale = 1):
	if muted:
		return
	
	var node = get_node(key)
	
	if not node:
		return 
	
	if is_audio_stream_player(node):
		play_node(node, pitch_scale)
	else:
		play_random_child(node)


func play_node(node, pitch_scale = 1):
	node.pitch_scale = pitch_scale
	node.play()


func is_audio_stream_player(node):
	return node and node.get('pitch_scale')


func play_random_child(node):
	var audios = node.get_children()
	var selection = RNG.choose(audios)
	play_node(selection)
	