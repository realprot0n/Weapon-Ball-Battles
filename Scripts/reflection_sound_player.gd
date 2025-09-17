extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var amountOfReflectionAttempts: int = 0

func attemptPlayReflectionSound() -> bool:
	amountOfReflectionAttempts += 1
	if (amountOfReflectionAttempts % 2) == 0:
		play()
		return true
	
	return false
