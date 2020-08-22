extends CanvasLayer

signal start_game()

const messagesByMinPoints = [
	[50, "The army is proud of you!"],
	[0, "You failed the nation!"]
]


# Called when the node enters the scene tree for the first time.
func _ready():
	$StartScreen.show()
	$EndScreen.hide()


func _get_message(points):
	
	for messageByMinPoints in messagesByMinPoints:
		if points > messageByMinPoints[0]:
			return messageByMinPoints[1]


func _end_game(points):
	$StartScreen.hide()
	$EndScreen.show()

#	Set messages
	$EndScreen/EndGameMessageLabel.set_text(_get_message(points))
	$EndScreen/PointsLabel.set_text("Points: " + str(points))


func _start_screen():
	$StartScreen.show()
	$EndScreen.hide()


func _start_game():
	$StartScreen.hide()
	$EndScreen.hide()
	
	emit_signal("start_game")


func _on_StartGameButton_pressed():
	_start_game()


func _on_RestartButton_pressed():
	_start_game()
