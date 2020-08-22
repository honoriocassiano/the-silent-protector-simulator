extends Node

#var bedPosition

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var Shoot

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$ShootSpawnTimer.start()
	
	randomize()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_ShootSpawnTimer_timeout():
	
	$ShootPath/ShootSpawnLocation.offset = randi()
	
	var shoot = Shoot.instance()
	
	add_child(shoot)
	
	var direction = $ShootPath/ShootSpawnLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	shoot.position = $ShootPath/ShootSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	shoot.rotation = direction
	# Set the velocity (speed & direction).
	shoot.linear_velocity = Vector2(rand_range(150, 250), 0)
	shoot.linear_velocity = shoot.linear_velocity.rotated(direction)
	
	pass # Replace with function body.
