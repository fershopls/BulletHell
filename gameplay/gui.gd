extends Node


onready var boss_health_progress = $screen/TextureProgress


func _ready():
	boss_health_progress.value = 1


func update_boss_health(qty):
	if qty == null:
		boss_health_progress.visible = false
	else:
		boss_health_progress.visible = true
		boss_health_progress.value = qty