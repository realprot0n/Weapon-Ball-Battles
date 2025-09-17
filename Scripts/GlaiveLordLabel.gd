extends Label

@onready var GlaiveLordBall: GlaiveLord = $"../../Glaive Lord"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlaiveLordBall == null:
		text = ""
		return
	
	text = "Glaives: " + str(GlaiveLordBall.amountOfGlaives) + \
		   "\nMax: " + str(GlaiveLordBall.maxAmountOfGlaives)
