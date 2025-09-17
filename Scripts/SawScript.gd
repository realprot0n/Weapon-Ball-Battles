extends RigidBody2D
class_name Saw

@onready var hurtbox: Hurtbox = $Hurtbox

@onready var sawBase: Node2D = $SawBase
@onready var sawCollision = $SawBase/SawCollision

@onready var healthDisplay: Label = $HealthDisplay
@export var starting_health: int = 100
var health: int = 0
var canSpinWeapon: bool = true

func _onHurtboxHit(area: WeaponHitbox) -> void:
	# replace when i make hitbox class
	if area == null or area.owner == self:
		return
		
	print("Saw got hit!")
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


func _ready():
	health = starting_health
	var rng = RandomNumberGenerator.new()
	var startingVelocity: int = 250
	
	var startingVelocityAngle: Vector2 = Vector2.from_angle(deg_to_rad(rng.randf_range(-360, 360)))
	print(startingVelocityAngle)
	
	linear_velocity = startingVelocityAngle * startingVelocity
	
	sawBase.rotate(deg_to_rad(rng.randf_range(0.0, 360.0)))
	
	hurtbox.area_entered.connect(_onHurtboxHit)


func _process(_delta):
	healthDisplay.text = str(health)
	
	if health <= 0:
		if sawCollision.hitBall != null:
			sawCollision.hitBall.sleeping = false
			sawCollision.hitBall.linear_velocity = sawCollision.hitBallVelocity
			sawCollision.hitBall.canSpinWeapon = true
		
		DingPlayer.playDing()
		queue_free()


func _physics_process(delta):
	if canSpinWeapon:
		var stage: int = floori((starting_health - health)/50) + 1
		var sawSpeed: float = 5 + (2.5*float(stage-1))
		
		if sawCollision.sawTimer < 0:
			sawBase.rotate(deg_to_rad(delta*60*sawSpeed*sawCollision.direction))
