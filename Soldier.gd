extends Area2D

#var bedPosition = Vector2()

export var speed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	# Hide at start screen
	hide()
	
	keep_in_circumference()

func start():
	# Show when game starts
	show()

func _physics_process(delta):
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# get auxiliary info
	var mousePosition = get_global_mouse_position()
	var bed_position = get_parent().get_node("Bed").position
	var angle_to_bed = atan2(position.y - bed_position.y, position.x - bed_position.x)
	var radius = get_parent().soldier_distance_from_bed
	
	var distance = bed_position.distance_to(mousePosition)

	var cosine = (mousePosition.x - bed_position.x) / distance
	var sine = (mousePosition.y - bed_position.y) / distance
	
	var target_x = cosine * radius + bed_position.x
	var target_y = sine * radius + bed_position.y
	
	# calculate if soldier should move clockwise or counterclockwise
	var orientation = (bed_position.y - position.y) * (target_x - bed_position.x) \
			- (target_y - bed_position.y) * (bed_position.x - position.x)

	if orientation > 0:  # if clockwise
		angle_to_bed += speed * delta
	else:  # if counterclockwise or colinear
		angle_to_bed -= speed * delta
		
	
	var new_vector = Vector2(cos(angle_to_bed), sin(angle_to_bed)) * radius
	
	# perform the movement
	position = bed_position + new_vector
	
	# always face towards bed
	rotation = -atan2(position.x - bed_position.x, position.y - bed_position.y)
	

func keep_in_circumference():
	var bed_position = get_parent().get_node("Bed").position

	var distance = bed_position.distance_to(position)

	var cosine = (position.x - bed_position.x) / distance
	var sine = (position.y - bed_position.y) / distance
	
	var target_x = cosine * get_parent().soldier_distance_from_bed + bed_position.x
	var target_y = sine * get_parent().soldier_distance_from_bed + bed_position.y
	var target_position = Vector2(target_x, target_y)
	
	position = target_position


func _on_RigidBody2D_body_entered(body):
	
	# TODO Play damage sound
	body.queue_free()
