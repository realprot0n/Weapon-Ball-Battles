extends RigidBody2D
class_name Bow


@export var starting_health: int = 100
@export var healthDisplay: Label
var health: int = 0

@export var hurtbox: Area2D
@export var bowBase: Node2D
@export var bowCollision: BowHitbox
var canSpinWeapon: bool = true

func _onHurtboxHit(area: WeaponHitbox) -> void:
	# replace when i make hitbox class
	if area == null:
		return
	if area.owner == self:
		return
	if area.owner.owner.owner == self:
		return
	
	print("Bow got hit!")
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


var numbOfArrows: int = 1
@export var arrowScene: PackedScene
@export var arrowBase: Node2D
func _onBowSpawnTimerTimeout() -> void:
	print("spawn arrow?")
	var remainingArrows: int = numbOfArrows
	for arrow_num in range(numbOfArrows):
		var arrow: Node2D = arrowScene.instantiate()
		$BowShootSound.play()
		arrowBase.add_child(arrow)
		arrow.owner = arrowBase
		print(arrow.owner)
		
		arrow.global_position = bowBase.global_position + (Vector2.from_angle(bowBase.global_rotation+ deg_to_rad(90)) * -30)
		arrow.global_rotation = bowBase.global_rotation
		
		if remainingArrows > 1:
			await get_tree().create_timer(.5/numbOfArrows).timeout
		
		remainingArrows -= 1
		
		while not canSpinWeapon:
			await get_tree().create_timer(.01).timeout
	
	$BowSpawnTimer.start()


func _ready():
	health = starting_health
	var rng = RandomNumberGenerator.new()
	var startingVelocity: int = 250
	
	var startingVelocityAngle: Vector2 = Vector2.from_angle(deg_to_rad(rng.randf_range(-360, 360)))
	print(startingVelocityAngle)
	
	linear_velocity = startingVelocityAngle * startingVelocity
	
	bowBase.rotate(deg_to_rad(rng.randf_range(0.0, 360.0)))
	
	hurtbox.area_entered.connect(_onHurtboxHit)


func _process(_delta):
	# print(linear_velocity)
	healthDisplay.text = str(health)
	if health <= 0:
		DingPlayer.playDing()
		queue_free()


func _physics_process(delta):
	if canSpinWeapon:
		bowBase.rotate(deg_to_rad(delta*60*5*bowCollision.direction))
