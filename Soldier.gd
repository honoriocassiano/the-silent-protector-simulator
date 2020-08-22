extends Area2D

const DISTANCE_FROM_BED = 100.0
#var bedPosition = Vector2()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	var bed = get_parent().get_node("Bed")
#	
#	global bedPositon = bed.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var mousePosition = get_global_mouse_position()
	var bed = get_parent().get_node("Bed")
	var bedPosition = bed.position
	
	var distance = bedPosition.distance_to(mousePosition)

	var cosine = (mousePosition.x - bedPosition.x) / distance
	var sine = (mousePosition.y - bedPosition.y) / distance
	
	position.x = cosine * DISTANCE_FROM_BED + bedPosition.x
	position.y = sine * DISTANCE_FROM_BED + bedPosition.y
	
	var angle = -atan2(mousePosition.x - bedPosition.x, mousePosition.y - bedPosition.y)
#	var angle = sine / cosine
	
	rotation = angle

func _on_Bed_position_ready(pos):
	pass # Replace with function body.
