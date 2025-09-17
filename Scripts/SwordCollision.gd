extends WeaponHitbox
class_name SwordHitbox

func _on_hit_hurtbox(area: Hurtbox):
	if area == null:
		return
	if area.owner == owner.owner:
		return
	
	print(damage)
	damage += 1
	$"../../SwordAudioStream".play()
	owner.start_pause_timer()
	area.owner.start_pause_timer()


func flipWeapon() -> void:
	direction *= -1
	#$"..".rotate(deg_to_rad(15*direction))


func _on_hit_hitbox(area: WeaponHitbox) -> void:
	if area == null:
		return
	print("sword flip")
	
	flipWeapon()
	
	ReflectionSoundManager.attemptPlayReflectionSound()
	
	# area.flipWeapon()


func _ready():
	area_entered.connect(_on_hit_hitbox)
	super()
