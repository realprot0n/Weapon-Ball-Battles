extends Node2D
class_name Arrow

var framesAlive: int = 0
const maxFramesAlive: int = 300 # 10s

var arrowSpeedPerSecond: int = 600
func _physics_process(delta):
	var deltaPos: Vector2 = Vector2.from_angle(rotation + deg_to_rad(-90)) * arrowSpeedPerSecond * delta
	
	var bowBall: Bow = owner.owner
	if bowBall.canSpinWeapon:
		position += deltaPos


func _ready() -> void:
	top_level = true
	#print(owner.owner)


func _process(delta):
	framesAlive += 1
	if framesAlive >= maxFramesAlive:
		queue_free()
