extends CanvasLayer

signal exit_main_menu()
signal start_game()
signal exit_game()
signal change_music_volume(value)
signal change_sound_volume(value)

const messagesByMinPoints = [
	[1000, "You sure have a lot of free time."],
	[200, "Congratulations, you are a true Silent Protector!"],
	[100, "The Protectors are proud of you!"],
	[50, "You did OK, soldier."],
	[0, "You failed as a Protector."]
]


# Called when the node enters the scene tree for the first time.
func _ready():
	$StartScreen.show()
	$TutorialScreen.hide()
	$PauseScreen.hide()
	$GameScreen.hide()
	$EndScreen.hide()
	$OptionsScreen.hide()


func _get_message(points):
	
	for messageByMinPoints in messagesByMinPoints:
		if points > messageByMinPoints[0]:
			return messageByMinPoints[1]


func update_score(score):
	$GameScreen/GameScoreLabel.set_text("Score: " + str(score))


func end_game(points):
	$StartScreen.hide()
	$TutorialScreen.hide()
	$PauseScreen.hide()
	$GameScreen.hide()
	$EndScreen.show()
	$OptionsScreen.hide()
	
	$EndScreen/QuitGameButton.visible = OS.get_name() != "HTML5"

#	Set messages
	$EndScreen/EndGameMessageLabel.set_text(_get_message(points))
	$EndScreen/PointsLabel.set_text("Score: " + str(points))


func _start_screen():
	$StartScreen.show()
	$TutorialScreen.hide()
	$PauseScreen.hide()
	$GameScreen.hide()
	$EndScreen.hide()
	$OptionsScreen.hide()
	
	$StartScreen/QuitGameButton.visible = OS.get_name() != "HTML5"


func _start_tutorial():
	$StartScreen.hide()
	$TutorialScreen.show()
	$PauseScreen.hide()
	$GameScreen.hide()
	$EndScreen.hide()
	$OptionsScreen.hide()


func _start_game():
	$StartScreen.hide()
	$TutorialScreen.hide()
	$PauseScreen.hide()
	$GameScreen.show()
	$EndScreen.hide()
	$OptionsScreen.hide()
	
	emit_signal("start_game")

func _pause_game():	
	if $GameScreen.visible:		
		if get_tree().paused == false:
			get_tree().paused = true	
			$PauseScreen.show()			
		else:
			get_tree().paused = false			
			$PauseScreen.hide()	
	
func _on_StartGameButton_pressed():

	if get_parent().count_tries > 0:
		_start_game()
	else:
		_start_tutorial()


func _on_RestartButton_pressed():
	_start_game()


func _on_GameStateControler_pause():
	_pause_game()


func _on_QuitGameButton_pressed():
	emit_signal("exit_game")


func _on_MainMenuButton_pressed():
	_start_screen()
	
	emit_signal("exit_main_menu")


func _on_GameOptionsButton_pressed():
	$StartScreen.hide()
	$PauseScreen.hide()
	$GameScreen.hide()
	$EndScreen.hide()
	$OptionsScreen.show()


func _on_MusicSlider_value_changed(value):
	emit_signal("change_music_volume",value)


func _on_SoundEffectSlider_value_changed(value):
	emit_signal("change_sound_volume",value)


func _on_FinishTutorialButton_pressed():
	_start_game()
