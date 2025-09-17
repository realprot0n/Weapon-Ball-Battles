extends Node2D
class_name Poisoner

var ballToPoison: RigidBody2D
var ballHasBeenSet: bool = false
@onready var poisonColorTimer = $PoisonColorTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ballHasBeenSet and ballToPoison == null:
		queue_free()


func _onPoisonTimerTimeout() -> void:
	if ballToPoison == null:
		return
	ballToPoison.health -= 1
	
	$PoisonHitStream.play()
	
	poisonColorTimer.start()
	ballToPoison.modulate = Color("db9cff")
	await poisonColorTimer.timeout
	if ballToPoison == null:
		return
	
	ballToPoison.modulate = Color("FFFFFF")
