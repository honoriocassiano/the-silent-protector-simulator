extends RigidBody2D

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

func _physics_process(delta):
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var mousePosition = get_global_mouse_position()
	var bed = get_parent().get_node("Bed")
	var bedPosition = bed.position

	var distance = bedPosition.distance_to(mousePosition)

	var cosine = (mousePosition.x - bedPosition.x) / distance
	var sine = (mousePosition.y - bedPosition.y) / distance

	var angle = -atan2(mousePosition.x - bedPosition.x, mousePosition.y - bedPosition.y)

	position.x = cosine * DISTANCE_FROM_BED + bedPosition.x
	position.y = sine * DISTANCE_FROM_BED + bedPosition.y

	rotation = angle

	pass

func _on_RigidBody2D_body_entered(body):
	
	# TODO Play damage sound
	body.queue_free()
