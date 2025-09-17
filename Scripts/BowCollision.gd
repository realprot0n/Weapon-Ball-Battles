extends WeaponHitbox
class_name BowHitbox

func _on_hit_hurtbox(area: Hurtbox):
	if area == null:
		return
	if area.owner == owner.owner:
		return
	
	# $"../../SwordAudioStream".play()
	# owner.start_pause_timer()
	# area.owner.start_pause_timer()


func flipWeapon() -> void:
	direction *= -1
	#$"..".rotate(deg_to_rad(15*direction))


func _on_hit_hitbox(area: WeaponHitbox) -> void:
	print(area.get_name())
	if area == null:
		return
	if area.owner.owner == $"../../Arrows":
		return
	
	#print(area.get_name())
	
	#print(owner)
	#print(area.owner.owner.owner)
	
	print("bow flip")
	
	flipWeapon()
	
	ReflectionSoundManager.attemptPlayReflectionSound()
	
	# area.flipWeapon()


func _ready():
	damage = 0
	area_entered.connect(_on_hit_hitbox)
	super()
