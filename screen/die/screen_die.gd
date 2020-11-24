extends CanvasLayer


var instruction = [
	"Los Jefes suelen repetir los mismos ataques. Aprendelos.",
	"Las balas son mas faciles de esquivar si te alejas.",
	"El disparo es automatico.",
	"Alejate de las balas del Jefe.",
	"Moverse demasiado es tan peligroso como quedarse inmovil.",
	"No te acerques demasiado al Jefe.",
	"Manten los ojos centrados en tu personaje.",
	"Acepta el hecho de que moriras.",
]

var motivation = [
	#"Encuentra los pasos correctos para mejorar en el juego.",
	"Con practica y tiempo llegaras a convertirte en un super jugador.",
	"Cuanto mas juegues, mas reduciras tu ansiedad a las balas.",
	"Tu definitivamente lograras esto. Con practica.",
	"Todo el mundo comienza desde abajo.",
	"Existe un momento adecuado para atacar y un momento adecuado para huir.",
]

onready var label = $Label
onready var label_start = $label_container/label_start
onready var tween = SH.tween(self)

func _ready():
	VisualServer.set_default_clear_color(Color())
	label.text = ""
	$Sprite.modulate = Color (.28,.16,.16)
	play()


func get_phrase():
	if RNG.chance(0.7):
		return RNG.choose(instruction)
	else:
		return RNG.choose(motivation)


func _process(delta):
	if not allow_start:
		if RNG.chance(0.3):
			label_start.text = str(round(percent)) + " %"
	else:
		label_start.text = "PRESIONA UN BOTON"


func _input(event):
	if event is InputEventKey or event is InputEventMouseButton or event is InputEventScreenTouch:
		if allow_start:
			get_tree().change_scene("res://gameplay/gameplay.tscn")


onready var timer_allow_start = SH.timer(self, 2, 'timeout_allow_start')
var percent = 0
func play():
	label.text = get_phrase()
	label.modulate = Color(1,1,1,0)
	
	var duration = 0.3
	tween.interpolate_property(label, 'modulate', Color(1,1,1,0), Color(1,1,1), duration, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	
	duration = 0.6
	tween.interpolate_property(label, 'visible_characters', 0, label.text.length(), duration, Tween.TRANS_SINE, Tween.EASE_OUT)
	
	duration = RNG.randomness(2, 0.5)
	tween.interpolate_property(self, 'percent', 0, 100, duration, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	
	
	timer_allow_start.start()
	tween.start()


var allow_start = false
func timeout_allow_start():
	allow_start = true
	$Sprite/AnimationPlayer.play("play")
	
	$label_container/AnimationPlayer.play("flick")