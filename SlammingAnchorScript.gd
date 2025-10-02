extends Node2D
class_name SlammingAnchor

@export var weightMultiplier: float = 50
var weightLevel: float = 1
var slammingBall: RigidBody2D

func ready() -> void:
	print("asdf")
	top_level = true


func _physics_process(delta: float) -> void:
	if slammingBall == null:
		return
	
	print(slammingBall.global_position)
	
	slammingBall.apply_force(Vector2(0, -weightMultiplier*weightLevel*delta))
	position = slammingBall.global_position
