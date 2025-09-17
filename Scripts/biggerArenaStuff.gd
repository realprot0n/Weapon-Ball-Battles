extends Node2D


func _ready():
	for child in get_children():
		if child is RigidBody2D:
			child.gravity_scale = 0
			
			var rng = RandomNumberGenerator.new()
			const startingVelocity: int = 500
			
			var startingVelocityAngle: Vector2 = Vector2.from_angle(deg_to_rad(rng.randf_range(-360, 360)))
			
			child.linear_velocity = startingVelocityAngle * startingVelocity


func _process(_delta):
	if Input.is_action_just_pressed("Reload"):
		get_tree().reload_current_scene()
		ProjectSettings.set_setting("physics/2d/default_gravity", 0)
