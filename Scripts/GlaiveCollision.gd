extends WeaponHitbox
class_name GlaiveHitbox


func _on_hit_hurtbox(area: Hurtbox):
	owner._on_hit_hurtbox(area)

