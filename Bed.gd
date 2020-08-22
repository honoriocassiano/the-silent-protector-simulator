extends Area2D

export var speed = 50
var screen_size

signal position_ready(pos)

func _ready():
	screen_size = get_viewport_rect().size
	
	position.x = screen_size.x / 3
	position.y = screen_size.y / 2
	
	emit_signal("position_ready", position)
	
#	TODO Hide when game start
#	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
#	The bed won't moves to the right, the screen that moves to the left
#	position.x += speed * delta
	
	pass
