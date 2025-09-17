extends RigidBody2D
class_name Dagger

@onready var hurtbox: Area2D = $Hurtbox

@onready var healthDisplay: Label = $HealthDisplay
@export var starting_health: int = 100
var health: int = 0

@onready var daggerBase: Node2D = $DaggerBase
@onready var daggerCollision: Area2D = $DaggerBase/DaggerCollision
var canSpinWeapon: bool = true
var daggerSpeed: int = 10

func _onHurtboxHit(area: WeaponHitbox) -> void:
	# replace when i make hitbox class
	if area == null:
		return
	if area.owner == self:
		return
	
	
	print("Dagger got hit!")
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
	canSpinWeapon = true
	

func _ready():
	health = starting_health
	
	var rng = RandomNumberGenerator.new()
	var startingVelocity: int = 250
	
	var startingVelocityAngle: Vector2 = Vector2.from_angle(deg_to_rad(rng.randf_range(-360, 360)))
	print(startingVelocityAngle)
	
	linear_velocity = startingVelocityAngle * startingVelocity
	
	daggerBase.rotate(deg_to_rad(rng.randf_range(0.0, 360.0)))
	
	hurtbox.area_entered.connect(_onHurtboxHit)


func _process(_delta):
	# print(linear_velocity)
	healthDisplay.text = str(health)
	if health <= 0:
		DingPlayer.playDing()
		queue_free()

func _physics_process(delta):
	if canSpinWeapon:
		daggerBase.rotate(deg_to_rad(delta*60*daggerSpeed*daggerCollision.direction))
