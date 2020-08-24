extends Area2D

#var bedPosition = Vector2()

export var speed = 7.5

var current_frame = 0
var distance_travelled_with_current_frame = 0


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

#	Process events only if Soldier is visible
	if visible:
		
		# get auxiliary info
		var mousePosition = get_global_mouse_position()
		var bed_position = get_parent().get_node("Bed").position
		var angle_to_bed = atan2(position.y - bed_position.y, position.x - bed_position.x)
		var radius = get_parent().soldier_distance_from_bed
		
		var distance = bed_position.distance_to(mousePosition)
	
		var cosine = (mousePosition.x - bed_position.x) / distance
		var sine = (mousePosition.y - bed_position.y) / distance
		
		var target_position = Vector2(cosine * radius + bed_position.x, 
									  sine * radius + bed_position.y)
		var target_angle_to_bed = atan2(target_position.y - bed_position.y, 
										target_position.x - bed_position.x)
		
		# determine length of step
		var step = min(abs(angle_to_bed - target_angle_to_bed), speed * delta)
		
		# add distance travelled
		distance_travelled_with_current_frame += step
		
		# determine if soldier should move clockwise or counterclockwise
		var orientation = (bed_position.y - position.y) * (target_position.x - bed_position.x) \
				- (target_position.y - bed_position.y) * (bed_position.x - position.x)
		
		step = step if orientation > 0 else -step
		
		var new_angle = angle_to_bed + step
		
		# perform the movement
		position = bed_position + Vector2(cos(new_angle), sin(new_angle)) * radius
		
		# determine whether to play next animation
		if distance_travelled_with_current_frame > 0.25:
			current_frame = (current_frame + 1) % 2
			distance_travelled_with_current_frame = 0
			
			$AnimatedSprite.set_frame(current_frame)
		
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
	body.on_contact()
