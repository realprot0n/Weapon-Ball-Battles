extends WeaponHitbox
class_name ArrowHitbox


func _on_hit_hurtbox(area: Hurtbox):
	var bowBall: Bow = owner.owner.owner
	if area == null:
		return
	if area.owner == bowBall:
		return
	ArrowHitAudioPlayer.play()
	print(owner.owner)
	print(owner)
	bowBall.start_pause_timer()
	area.owner.start_pause_timer()
	bowBall.numbOfArrows += 1
	
	owner.queue_free()


func _on_hit_hitbox(area: WeaponHitbox) -> void:
	var bowBall: Bow = owner.owner.owner
	var arrowBase: Node2D = owner.owner
	if area == null:
		return
	if area.owner == bowBall:
		return
	if area.owner.owner == arrowBase:
		return
	
	print("arrow flip")
	
	ReflectionSoundManager.attemptPlayReflectionSound()
	owner.queue_free()
	
	# area.flipWeapon()


func _ready():
	damage = 1
	area_entered.connect(_on_hit_hitbox)
