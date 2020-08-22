extends RigidBody2D

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
	
	position.x = cosine * get_parent().soldier_distance_from_bed + bedPosition.x
	position.y = sine * get_parent().soldier_distance_from_bed + bedPosition.y
	
	var angle = -atan2(mousePosition.x - bedPosition.x, mousePosition.y - bedPosition.y)
	
	rotation = angle

func _on_RigidBody2D_body_entered(body):
	
	# TODO Play damage sound
	body.queue_free()
