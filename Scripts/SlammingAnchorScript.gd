extends Node2D
class_name SlammingAnchor

@export var weightMultiplier: float = 50
var weightLevel: float = 1
var slammingBall: RigidBody2D

func _ready() -> void:
	print("asdf")
	top_level = true

var ballVelocityLastFrame: Vector2
func _physics_process(delta: float) -> void:
	if slammingBall == null:
		return
	ballVelocityLastFrame = slammingBall.linear_velocity
	
	slammingBall.apply_force(Vector2(0, -weightMultiplier*weightLevel*delta))
	position = slammingBall.global_position
