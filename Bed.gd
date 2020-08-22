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
	var velocity = Vector2()  # The player's movement vector.
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		# $AnimatedSprite.play()
	# else:
		# $AnimatedSprite.stop()
		
	# perform the actual movement...
	position += velocity * delta
	
	# ... as much as the bed and soldier remain on the screen
	var soldier_distance = get_parent().soldier_distance_from_bed
	position.x = clamp(position.x, 0 + soldier_distance, 
					   screen_size.x - soldier_distance)
	position.y = clamp(position.y, 0 + soldier_distance, 
					   screen_size.y - soldier_distance)
