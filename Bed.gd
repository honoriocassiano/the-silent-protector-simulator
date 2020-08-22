extends Area2D

export var speed = 50
var screen_size

signal game_over()

func start():
	# Show when game starts
	show()

func _ready():
	# Hide at start screen
	hide()

	screen_size = get_viewport_rect().size
	
	position.x = screen_size.x / 3
	position.y = screen_size.y / 2
	
	emit_signal("position_ready", position)
	
#	TODO Hide when game start
#	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	# calculate the final velocity vector
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	# perform the actual movement
	position += velocity * delta
	
	# ensure bed and soldier remain on the screen
	var soldier_distance = get_parent().soldier_distance_from_bed
	
	position.x = clamp(position.x, 0 + soldier_distance, 
					   screen_size.x - soldier_distance)
	position.y = clamp(position.y, 0 + soldier_distance, 
					   screen_size.y - soldier_distance)


func _on_Area2D_body_entered(body):

	body.queue_free()

	emit_signal("game_over")
