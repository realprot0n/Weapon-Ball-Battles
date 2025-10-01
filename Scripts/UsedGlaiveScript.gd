extends RigidBody2D
class_name UsedGlaive

func getRandomDirection() -> int:
	return [-1, 1].pick_random()

# Called when the node enters the scene tree for the first time.
func _ready():
	top_level = true
	linear_velocity.x = 200 * getRandomDirection()
	linear_velocity.y = -200


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation_degrees += deg_to_rad(5)
	

func _onRemoveSelfTimerTimeout():
	queue_free()
