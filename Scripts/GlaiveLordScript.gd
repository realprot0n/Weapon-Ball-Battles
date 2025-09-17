extends RigidBody2D
class_name GlaiveLord

@onready var hurtbox: Area2D = $Hurtbox

@onready var healthDisplay: Label = $HealthDisplay
@export var starting_health: int = 100
var health: int = 0

@onready var glaiveBase: Node2D = $GlaiveBase
@onready var glaiveScene: PackedScene  = preload("res://Scenes/Balls/glaive_projectile.tscn")
@onready var glaiveHitPlayer: AudioStreamPlayer = $GlaiveHitSoundPlayer
@onready var glaiveReadyPlayer: AudioStreamPlayer = $GlaiveReadySoundPlayer
#@onready var swordCollision: Area2D = $SwordBase/SwordCollision
var canSpinWeapon: bool = true
var maxAmountOfGlaives: float = 1
var amountOfGlaives: int = 0

func _onHurtboxHit(area: WeaponHitbox) -> void:
	# replace when i make hitbox class
	if area == null:
		return
	if area.owner.owner.owner == self:
		return
	
	print("Glaive Lord got hit!")
	health -= area.damage
	area._on_hit_hurtbox(hurtbox)


@onready var pauseTimer: Timer = $BallPauseTimer
var tempVelocity: Vector2
func start_pause_timer() -> void:
	if sleeping == true:
		return
	
	tempVelocity = linear_velocity
	linear_velocity = Vector2.ZERO
	sleeping = true
	canSpinWeapon = false
	pauseTimer.start()


func _onPauseTimerTimeout() -> void:
	sleeping = false
	linear_velocity = tempVelocity
	tempVelocity = Vector2.ZERO
	canSpinWeapon = true


func _onSpawnTimerTimeout() -> void:
	if amountOfGlaives >= floor(maxAmountOfGlaives):
		return
	
	var glaiveToAdd = glaiveScene.instantiate()
	
	glaiveBase.add_child(glaiveToAdd)
	glaiveToAdd.owner = glaiveBase
	amountOfGlaives += 1
	glaiveReadyPlayer.play()


func _setEveryGlaivesPosition() -> void:
	var amountOfGlaivesByChildren: int = len(glaiveBase.get_children())
	if amountOfGlaivesByChildren != amountOfGlaives:
		amountOfGlaives = amountOfGlaivesByChildren
	
	var distanceDegrees: float = 360.0/amountOfGlaivesByChildren
	var distFromCenter: int = 20
	
	var degrees: float = 0
	for glaive in glaiveBase.get_children():
		degrees += distanceDegrees
		glaive.position = Vector2(distFromCenter, 0).rotated(deg_to_rad(degrees))
		



func _ready():
	health = starting_health
	var rng = RandomNumberGenerator.new()
	var startingVelocity: int = 250
	
	var startingVelocityAngle: Vector2 = Vector2.from_angle(deg_to_rad(rng.randf_range(-360, 360)))
	print(startingVelocityAngle)
	
	linear_velocity = startingVelocityAngle * startingVelocity
	
	glaiveBase.rotate(deg_to_rad(rng.randf_range(0.0, 360.0)))
	
	hurtbox.area_entered.connect(_onHurtboxHit)
	$GlaiveSpawningTimer.timeout.connect(_onSpawnTimerTimeout)


func _process(_delta):
	# print(linear_velocity)
	healthDisplay.text = str(health)
	if health <= 0:
		DingPlayer.playDing()
		queue_free()

func _physics_process(delta):
	if canSpinWeapon:
		glaiveBase.rotate(deg_to_rad(delta*60*5))
	_setEveryGlaivesPosition()
