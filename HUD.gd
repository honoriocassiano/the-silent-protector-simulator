extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Remove this line when implement "Start"
	$StartScreen.hide()
	
	pass # Replace with function body.

func _on_Button_pressed():
	$StartScreen.hide()
