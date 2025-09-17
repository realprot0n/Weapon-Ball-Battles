extends RigidBody2D
class_name Ball

@onready var hurtbox: Hurtbox = $Hurtbox

@onready var healthDisplay: Label = $HealthDisplay
var health: int = 100
var invincibilityTimer: int = 0

func _onHurtboxHit(area: WeaponHitbox) -> void:
	# replace when i make hitbox class
	if area == null or area.owner == owner.owner:
		return
	if invincibilityTimer > 0:
		return
	
	print("Ball got hit!")
	health -= area.damage
	invincibilityTimer = 1
	
	area._on_hit_hurtbox(hurtbox)
	start_pause_timer()


@onready var pauseTimer: Timer = $BallPauseTimer
var tempVelocity: Vector2
func start_pause_timer() -> void:
	tempVelocity = linear_velocity
	linear_velocity = Vector2.ZERO
	sleeping = true
	pauseTimer.start()


func _onPauseTimerTimeout() -> void:
	linear_velocity = tempVelocity
	tempVelocity = Vector2.ZERO
	sleeping = false


func _ready():
	var rng = RandomNumberGenerator.new()
	var startingVelocity: int = 250
	
	var startingVelocityAngle: Vector2 = Vector2.from_angle(deg_to_rad(rng.randf_range(-360, 360)))
	print(startingVelocityAngle)
	
	linear_velocity = startingVelocityAngle * startingVelocity
	
	hurtbox.area_entered.connect(_onHurtboxHit)
	$BallPauseTimer.timeout.connect(_onPauseTimerTimeout)


func _process(_delta):
	# print(linear_velocity)
	invincibilityTimer -= 1
	healthDisplay.text = str(health)
	
	
	if health <= 0:
		queue_free()
