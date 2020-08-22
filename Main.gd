extends Node

#var bedPosition

export (PackedScene) var Shoot
export var soldier_distance_from_bed = 100.0

# Called when the node enters the scene tree for the first time.
func _ready():

	randomize()

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _new_game():

	$Bed.start()
	$Soldier.start()

	$ShootSpawnTimer.start()

	pass

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


func _on_HUD_start_game():

	_new_game()


func _end_game():

#	TODO Count the points
	var points = 60

	$ShootSpawnTimer.stop()

#	Delete all the shoots that still active
	get_tree().call_group("shoots", "queue_free")

	$Bed.hide()
	$Soldier.hide()

	$HUD.end_game(points)


func _on_Bed_game_over():
	_end_game()
