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

#	var diff = mousePosition - bedPositon
	
	var cosine = (mousePosition.x - bedPosition.x) / distance
	var sine = (mousePosition.y - bedPosition.y) / distance
	
#	position.x = cosine * DISTANCE_FROM_BED + bedPosition.x
#	position.y = sine * DISTANCE_FROM_BED + bedPosition.y

	position.x = cosine * DISTANCE_FROM_BED + bedPosition.x
	position.y = sine * DISTANCE_FROM_BED + bedPosition.y
	
#	print_debug(distance)
#	print_debug(cosine, sine)
#	print_debug(position)
	
#	var angle = atan2(diff.y, diff.x)
#	var tangent = diff.y / diff.x
	
#	print_debug(angle)
	
#	position = bedPosition
#	position = mousePosition

func _on_Bed_position_ready(pos):
	pass # Replace with function body.
