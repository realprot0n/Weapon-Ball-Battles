extends WeaponHitbox
class_name SawHitbox

var sawTimer: int = -1
var hitBall: RigidBody2D
var hitBallVelocity: Vector2
var hitBallDirection: int
var ownVelocity: Vector2

@onready var sawBall = $"../.."

func _on_hit_hurtbox(area: Hurtbox):
	if area == null:
		return
	if area.owner == owner:
		return
	
	hitBall = area.owner
	hitBallVelocity = hitBall.linear_velocity
	hitBall.canSpinWeapon = false
	hitBall.sleeping = true
	ownVelocity = sawBall.linear_velocity
	sawBall.sleeping = true
	
	var stage: int = floori((sawBall.starting_health - sawBall.health)/50) + 1
	print(stage)
	sawTimer = stage*10

func flipWeapon() -> void:
	direction *= -1
	$"..".scale.x *= -1


func _on_hit_hitbox(area: WeaponHitbox) -> void:
	if area == null:
		return
	
	flipWeapon()
	
	ReflectionSoundManager.attemptPlayReflectionSound()
	
	# area.flipWeapon()


func _process(_delta):
	if sawTimer > 0 and sawTimer % 2 == 0 and hitBall != null:
		hitBall.health -= 1
		$"../../SawAudioStream".play()
	elif sawTimer == 0:
		if hitBall != null:
			hitBall.sleeping = false
			hitBall.linear_velocity = hitBallVelocity
			hitBall.canSpinWeapon = true
			hitBall = null
		
		sawBall.sleeping = false
		sawBall.linear_velocity = ownVelocity
	
	sawTimer -= 1


func _ready():
	area_entered.connect(_on_hit_hitbox)
	super()
	if direction == 1:
		$"..".scale.x *= -1
