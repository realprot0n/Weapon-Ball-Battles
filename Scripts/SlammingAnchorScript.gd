extends Node2D
class_name SlammingAnchor

@export var weightMultiplier: float = 4000
var weightLevel: float = 1
var slammingBall: RigidBody2D
var slamPlayer: AudioStreamPlayer
var anchorBall: RigidBody2D

func _ready() -> void:
	print("asdf")
	top_level = true
	z_index = -100

var potentialDamage: int = 0
var velocityLastFrame: Vector2
func _physics_process(delta: float) -> void:
	if slammingBall == null:
		queue_free()
	
	position = slammingBall.global_position
	if slammingBall.sleeping:
		return
	
	potentialDamage = floori(velocityLastFrame.y/200 * (1 + weightLevel*.25))
	
	if (sign(velocityLastFrame.y) == 1) and sign(slammingBall.linear_velocity.y) == -1:
		slammingBall.health -= potentialDamage
		anchorBall.potentialDamage = 0
		slamPlayer.play()
		queue_free()
	
	anchorBall.potentialDamage = potentialDamage
	
	velocityLastFrame = slammingBall.linear_velocity
	
	slammingBall.apply_central_force(Vector2(0, weightMultiplier*weightLevel*10/512))
