extends Area2D
class_name WeaponHitbox

static var amountOfWeapons = 0
@export var damage: int = 1
var direction: int = 1
var canSpinWeapon: bool = true

func _on_hit_hurtbox(area: Hurtbox):
	if area == null:
		return
	if area.owner == owner.owner:
		return
	
	print(damage)
	damage += 1


func _on_hit_hitbox(area: WeaponHitbox) -> void:
	if area == null:
		return
	
	
	direction *= -1


func _ready():
	amountOfWeapons += 1
	if (amountOfWeapons % 2) == 0:
		direction = 1
	else:
		direction = -1
		
	
	area_entered.connect(_on_hit_hitbox)
	
