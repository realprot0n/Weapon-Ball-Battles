extends Label

@onready var spearBall: Spear = $"../../spear"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spearBall == null:
		set_self_modulate(Color("4d4d4d"))
		return
	
	text = "Len/Dmg: " + str((1 + (.5*spearBall.hits)))
