extends Label

@onready var scytheBall: Scythe = $"../../Scythe"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if scytheBall == null:
		text = ""
		return
	
	text = "Poisons: " + str(scytheBall.poisonsBase.get_child_count())
