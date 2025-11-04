class_name FireballData extends BaseSpell

func _ready() -> void:
	icon_texture = preload("res://icons/gravity-ui--arrow-shape-up.png")
	spell_name = "Fireball"

func _spell_effect(complexity: float):
	print("Fireball cast with complexity " + str(complexity))