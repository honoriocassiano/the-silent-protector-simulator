extends Node

export (PackedScene) var Shoot
export var soldier_distance_from_bed = 100.0

var score

# Called when the node enters the scene tree for the first time.
func _ready():
	$InicialScreenMusic.play()
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _new_game():

	score = 0

	$Bed.start()
	$Soldier.start()
	#stop existing music when starting or restarting the game
	$InicialScreenMusic.stop()
	$GameOverMusic.stop()
	$GameOverScream.stop()
	
	#start the game music and background
	$BackgroundMusic.play()
	$BackgroundSound.play()
	
	$ShootSpawnTimer.start()
	$ScoreTimer.start()

	$HUD.update_score(score)


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

	$ShootSpawnTimer.stop()
	$ScoreTimer.stop()

#	Delete all the shoots that still active
	get_tree().call_group("shoots", "queue_free")

	$Bed.hide()
	$Soldier.hide()
	#stop the game music and starts the game over music
	$BackgroundMusic.stop()
	$BackgroundSound.stop()
	$GameOverScream.play()
	$GameOverMusic.play()
	
	$HUD.end_game(score)


func _on_Bed_game_over():
	_end_game()


func _on_ScoreTimer_timeout():

	score += 1

	$HUD.update_score(score)
