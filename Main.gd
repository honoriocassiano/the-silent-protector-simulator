extends Node

#var bedPosition

export (PackedScene) var Shoot
export var soldier_distance_from_bed = 100.0

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

	var spawnPosition = $ShootPath/ShootSpawnLocation.position
	
	var bedPosition = $Bed.position
	var distance = bedPosition.distance_to(spawnPosition)

#	var cosine = (spawnPosition.x - bedPosition.x) / distance
#	var sine = (spawnPosition.y - bedPosition.y) / distance

	var originalDirection = $ShootPath/ShootSpawnLocation.rotation

	var direction = -atan2(spawnPosition.x - bedPosition.x, spawnPosition.y - bedPosition.y)

#	position.x = cosine * DISTANCE_FROM_BED + bedPosition.x
#	position.y = sine * DISTANCE_FROM_BED + bedPosition.y

#	var direction = $ShootPath/ShootSpawnLocation.rotation + PI / 2
#	var direction = $ShootPath/ShootSpawnLocation.rotation
	# Set the mob's position to a random location.
#	shoot.position = $ShootPath/ShootSpawnLocation.position
	# Add some randomness to the direction.
#	direction += rand_range(-PI / 4, PI / 4)

#	var finalDirection = originalDirection
	var finalDirection = direction

	shoot.position = spawnPosition
	shoot.rotation = finalDirection
	shoot.linear_velocity = -Vector2(0, 150).rotated(finalDirection)
#	shoot.linear_velocity = Vector2(rand_range(150, 250), 0).rotated(direction)
#	shoot.linear_velocity = shoot.linear_velocity.rotated(direction)
	
	add_child(shoot)
