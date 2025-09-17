extends WeaponHitbox
class_name ScytheHitbox

@export var scythe: Scythe
@export var scytheBase: Node2D
@export var poisonScene: PackedScene

func _on_hit_hurtbox(area: Hurtbox):
	if area == null:
		return
	if area.owner == owner.owner:
		return
	
	$"../../ScytheAudioStream".play()
	scythe.start_pause_timer()
	area.owner.start_pause_timer()
	
	var instantiatedPoisonScene: Poisoner = poisonScene.instantiate()
	instantiatedPoisonScene.ballToPoison = area.owner
	scythe.poisonsBase.add_child(instantiatedPoisonScene)


func flipWeapon() -> void:
	direction *= -1
	scytheBase.scale.x *= -1
	#$"..".rotate(deg_to_rad(15*direction))


func _on_hit_hitbox(area: WeaponHitbox) -> void:
	if area == null:
		return
	print("sword flip")
	
	flipWeapon()
	
	ReflectionSoundManager.attemptPlayReflectionSound()
	
	# area.flipWeapon()


func _ready():
	damage = 0
	area_entered.connect(_on_hit_hitbox)
	super()
	
	scytheBase.scale.x *= -direction
