extends Label

@onready var bowBall: Bow = $"../../Bow"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if bowBall == null:
		text = ""
		return
	
	text = "Arrows: " + str(bowBall.numbOfArrows)
