extends Area2D


func _on_ball_enter(area: Area2D) -> void:
	$BouncePlayer.play()


# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(_on_ball_enter)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
