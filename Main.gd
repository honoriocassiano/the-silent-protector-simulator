extends Node

export (PackedScene) var Weapon
export var soldier_distance_from_bed = 100.0

export var count_tries = 0
export var final_weapon_spawn_freq = 0.8  # in seconds
export var weapon_spawn_decrement = 0.05  # in seconds

var highest_score = null
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	$InicialScreenMusic.play()
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _exit_main_menu():
	$InicialScreenMusic.play()

	$BackgroundMusic.stop()
	$BackgroundSound.stop()
	$GameOverScream.stop()
	$GameOverMusic.stop()
	
	$ShootSpawnTimer.stop()
	$ScoreTimer.stop()

#	Delete all the shoots that still active
	get_tree().call_group("shoots", "queue_free")

	$Bed.hide()
	$Soldier.hide()


func _new_game():

	score = 0
	count_tries += 1

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
	
	if highest_score != null:
		$HUD/GameScreen/HighscoreLabel.text = "Best: %d" % highest_score
		$HUD/GameScreen/HighscoreLabel.show()
	else:
		$HUD/GameScreen/HighscoreLabel.hide()


func _on_ShootSpawnTimer_timeout():
	# increase spawn frequency from 2 seg down to 800 ms, 50 ms at a time
	$ShootSpawnTimer.wait_time = \
		max(final_weapon_spawn_freq, 
			$ShootSpawnTimer.wait_time - weapon_spawn_decrement)
	
	$ShootPath/ShootSpawnLocation.offset = randi()

	var shoot = Weapon.instance()
	
	shoot.init()

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
	shoot.linear_velocity = -Vector2(0, shoot.speed).rotated(finalDirection)
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
	
	if highest_score == null:
		$HUD/EndScreen/HighscoreLabel.hide()
		highest_score = score
	elif score > highest_score:
		$HUD/EndScreen/HighscoreLabel.show()
		highest_score = score
	else:
		$HUD/EndScreen/HighscoreLabel.hide()
	
	$HUD.end_game(score)


func _on_Bed_game_over():
	_end_game()


func _on_ScoreTimer_timeout():

	score += 1

	$HUD.update_score(score)


func _on_HUD_exit_game():
	get_tree().quit()


func _on_HUD_exit_main_menu():
	_exit_main_menu()


func _on_HUD_change_music_volume(value):
	var music_list = get_tree().get_nodes_in_group("music")
	for node in music_list:
		node.volume_db=value
	


func _on_HUD_change_sound_volume(value):
	var sound_list = get_tree().get_nodes_in_group("sound")
	for node in sound_list:
		node.volume_db=value
