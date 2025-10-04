extends Label

@onready var anchorBall: AnchorBall = $"../../Anchor"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if anchorBall == null:
		text = ""
		return
	
	text = "Weight: " + str(anchorBall.anchorWeight) + "\nDamage/Speed: " + str(anchorBall.potentialDamage)
