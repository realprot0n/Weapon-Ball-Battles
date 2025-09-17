extends WeaponHitbox
class_name SpearHitbox

@onready var spearScript: Spear = $"../../.."

func _on_hit_hurtbox(area: Hurtbox):
	if area == null:
		return
	if area.owner == owner:
		return
	
	spearScript.hits += 1
	damage = 1 + (spearScript.hits*.5)
	$"../../../SpearAudioStream".play()
	spearScript.start_pause_timer()
	area.owner.start_pause_timer()


func flipWeapon() -> void:
	direction *= -1
	#$"..".rotate(deg_to_rad(15*direction))


func _on_hit_hitbox(area: WeaponHitbox) -> void:
	if area == null:
		return
	print("spear flip")
	
	flipWeapon()
	
	ReflectionSoundManager.attemptPlayReflectionSound()
	
	# area.flipWeapon()


func _ready():
	area_entered.connect(_on_hit_hitbox)
	super()
