extends Camera2D


var following_node


var _zoom
var _zoom_delta_scale = 1

onready var camera_shaker = $camera_shaker
onready var tween = SH.tween(self)

var tween_trans = Tween.TRANS_QUINT
var tween_ease = Tween.EASE_OUT

func _process(delta):
	if not is_instance_valid(following_node):
		following_node = null
	if following_node:
		global_position = following_node.global_position


func tween_zoom(zoom, duration = 1):
	zoom = Vector2.ONE / zoom
	tween.interpolate_property(self, 'zoom', self.zoom, zoom, duration, tween_trans, tween_ease)
	tween.start()
	

func drag_margin(margin):
	if margin:
		drag_margin_h_enabled = true
		drag_margin_v_enabled = true
		drag_margin_top = margin
		drag_margin_left = margin
		drag_margin_bottom = margin
		drag_margin_left = margin
	else:
		drag_margin_h_enabled = false
		drag_margin_v_enabled = false
	

func look_at_boss():
	var boss = ROOT.gameplay.get_boss()
	if not boss:
		return false
	
	following_node = boss
	drag_margin(0)
	tween_zoom(2)
	return true


func look_at_player():
	following_node = ROOT.player
	drag_margin(0.2)
	tween_zoom(1)