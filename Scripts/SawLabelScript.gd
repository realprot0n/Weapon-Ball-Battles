extends Label

@onready var sawBall: Saw = $"../../Saw"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if sawBall == null:
		set_self_modulate(Color("4d4d4d"))
		return
	
	var stage: int = floori((sawBall.starting_health - sawBall.health)/50) + 1
	var sawSpeed: float = 5 + float(2.5*(stage-1))
	var sawHits: int = 5*stage
	
	text = "Speed: " + str(sawSpeed) + "\nHits: " + str(sawHits)
