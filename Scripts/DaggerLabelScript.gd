extends Label

@onready var daggerBall: Dagger = $"../../Dagger"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if daggerBall == null:
		text = ""
		return
	
	text = "Speed: " + str(daggerBall.daggerSpeed)
