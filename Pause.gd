extends Node

signal pause()
signal unpause()

func _ready():
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		emit_signal("pause")

