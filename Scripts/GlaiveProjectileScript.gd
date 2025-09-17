extends Node2D
class_name GlaiveProjectile

const startingPierce: int = 3
var remainingPierce: int = 0
var spinSpeed: int = 10


@onready var collision: Area2D = $GlaiveCollision
@onready var sprite: Sprite2D = $Sprite2D

@onready var stage3Sprite = preload("res://Images/glaive.png")
@onready var stage2Sprite = preload("res://Images/glaives 2p.png")
@onready var stage1Sprite = preload("res://Images/glaives 1p.png")

@onready var usedGlaiveScene: PackedScene = preload("res://Scenes/Balls/used_glaive.tscn")

func _on_hit_hurtbox(area: Hurtbox):
	if area == null:
		return
	
	print("the glaive hit")
	
	var ball: GlaiveLord = owner.owner
	
	ball.maxAmountOfGlaives += .5
	print(ball.maxAmountOfGlaives)
	
	ball.start_pause_timer()
	area.owner.start_pause_timer()
	ball.glaiveHitPlayer.play()
	
	remainingPierce -= 1
	if remainingPierce <= 0:
		onDie()


func _on_hit_hitbox(area: WeaponHitbox):
	var ball: GlaiveLord = owner.owner
	
	if area == null:
		return
	if area.owner.owner.owner == owner.owner:
		return
	
	ReflectionSoundManager.attemptPlayReflectionSound()
	
	remainingPierce -= 1
	if remainingPierce <= 0:
		onDie()

func onDie():
	owner.owner.amountOfGlaives -= 1
	var usedGlaive = usedGlaiveScene.instantiate()
	usedGlaive.position = global_position
	owner.owner.add_child(usedGlaive)
	usedGlaive.owner = owner.owner
	print(usedGlaive.owner)
	queue_free()
	

# Called when the node enters the scene tree for the first time.
func _ready():
	collision.area_entered.connect(_on_hit_hitbox)
	remainingPierce = startingPierce
	
	var rng = RandomNumberGenerator.new()
	rotate(deg_to_rad(rng.randf_range(-360.0, 360.0)))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(deg_to_rad(spinSpeed*delta*60))
	#if (remainingPierce == 0) and not zeroPierceMode:
	#	zeroPierceMode = true
	#	set_owner(ball.get_child(1))
		
	#	direction = 1 if randi() % 2 == 0 else -1
	#	velocityY = 200
	
	#if zeroPierceMode:
	#	position.x += direction * glaiveXSpeedPerSecond * delta
	#	velocityY -= gravity * delta
	#	position.y += velocityY * delta
	
	# var alphaLevel: float = float(remainingPierce)/startingPierce
	# sprite.set_self_modulate(Color(1, alphaLevel, alphaLevel, alphaLevel))
	
	match remainingPierce:
		3:
			sprite.texture = stage3Sprite
		2:
			sprite.texture = stage2Sprite
		1:
			sprite.texture = stage1Sprite
	#	0:
	#		sprite.texture = stage0Sprite
