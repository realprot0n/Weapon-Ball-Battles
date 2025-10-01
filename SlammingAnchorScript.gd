extends Node2D
class_name SlammingAnchor

@export var weightMultiplier: float = 50
var weightLevel: float = 1
var slammingBall: RigidBody2D

func ready() -> void:
	top_level = true
