extends WeaponHitbox
class_name AnchorHitbox

@onready var ball: AnchorBall = $"../.."
@onready var anchorBase: Node2D = $".."
@onready var slammingAnchorBase: Node = $"../../SlammingAnchors"

@export var slammingAnchor: PackedScene
@export var rechargeTime: float = 2
var rechargeTimer: float
var defaultSpriteScale: Vector2


var collisionsDisabled = false
func setCollisionEnabled(enabled: bool) -> void:
	collisionsDisabled = not enabled
	for child in get_children():
		child.disabled = not enabled

func _on_hit_hurtbox(area: Hurtbox):
	if area == null:
		return
	if area.owner == owner.owner:
		return
	
	rechargeTimer = 0
	anchorBase.scale = Vector2(0, 0)
	setCollisionEnabled(false)
	
	print(slammingAnchor)
	var slammingAnchorToAdd = slammingAnchor.instantiate()
	print(slammingAnchorToAdd)
	slammingAnchorToAdd.weightLevel = ball.anchorWeight
	slammingAnchorToAdd.slammingBall = area.owner
	slammingAnchorToAdd.slamPlayer = $"../../AnchorSlamStream"
	slammingAnchorToAdd.anchorBall = ball
	slammingAnchorBase.add_child(slammingAnchorToAdd)
	
	ball.anchorWeight += 1
	$"../../AnchorHitStream".play()
	owner.start_pause_timer()
	area.owner.start_pause_timer()


func flipWeapon() -> void:
	direction *= -1
	#$"..".rotate(deg_to_rad(15*direction))


func _on_hit_hitbox(area: WeaponHitbox) -> void:
	if area == null:
		return
	print("anchor flip")
	
	flipWeapon()
	
	ReflectionSoundManager.attemptPlayReflectionSound()
	
	# area.flipWeapon()


func _ready():
	damage = 0
	
	area_entered.connect(_on_hit_hitbox)
	defaultSpriteScale = anchorBase.scale
	super()

func _physics_process(delta: float) -> void:
	if ball.sleeping:
		return
	
	rechargeTimer += delta
	if not collisionsDisabled:
		return
	
	if rechargeTimer > rechargeTime:
		setCollisionEnabled(true)
		anchorBase.scale = defaultSpriteScale
	elif rechargeTimer > rechargeTime/2:
		anchorBase.scale = defaultSpriteScale - -defaultSpriteScale * (rechargeTimer-rechargeTime)/(rechargeTime/2)
