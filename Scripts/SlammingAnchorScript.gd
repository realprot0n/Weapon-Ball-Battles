extends Node2D
class_name SlammingAnchor

@export var weightMultiplier: float = 2000
var weightLevel: float = 1
var slammingBall: RigidBody2D
var slamPlayer: AudioStreamPlayer

func _ready() -> void:
	print("asdf")
	top_level = true
	z_index = -100

var velocityLastFrame: Vector2
func _physics_process(delta: float) -> void:
	if slammingBall == null:
		queue_free()
	
	position = slammingBall.global_position
	if slammingBall.sleeping:
		return
	
	if (sign(velocityLastFrame.y) == 1) and sign(slammingBall.linear_velocity.y) == -1:
		slammingBall.health -= weightLevel
		slamPlayer.play()
		queue_free()
	
	velocityLastFrame = slammingBall.linear_velocity
	
	slammingBall.apply_central_force(Vector2(0, weightMultiplier*weightLevel*delta))
