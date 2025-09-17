extends WeaponHitbox
class_name DaggerHitbox

@onready var daggerScript: Dagger = $"../.."

func _on_hit_hurtbox(area: Hurtbox):
	if area == null:
		return
	if area.owner == owner:
		return
	
	print(daggerScript.daggerSpeed)
	daggerScript.daggerSpeed += 5
	$"../../DaggerAudioStream".play()
	daggerScript.start_pause_timer()
	area.owner.start_pause_timer()


func flipWeapon() -> void:
	direction *= -1
	#$"..".rotate(deg_to_rad(15*direction))


func _on_hit_hitbox(area: WeaponHitbox) -> void:
	if area == null:
		return
	print("dagger flip")
	
	flipWeapon()
	
	ReflectionSoundManager.attemptPlayReflectionSound()
	
	# area.flipWeapon()


func _ready():
	area_entered.connect(_on_hit_hitbox)
	super()
