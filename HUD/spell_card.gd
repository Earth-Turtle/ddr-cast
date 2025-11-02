extends Control

@export var spell_name: String = "Placeholder spell"
@export var spell_icon: Texture = preload("res://icons/gravity-ui--triangle-exclamation.png")
@export var spell_input: Array[ComplexityCalculator.Direction] = []

enum CastState {IDLE, IN_PROGRESS, COMPLETED, INVALID}

signal spell_completed(spell: BaseSpell, complexity: float)

## If cast_progress is 0, a cast has not been started and all icons should be clear
## cast_progress == -1: cast in progress, but it's invalid for this spell. Full card gray
## cast_progress > 0 and < spell_input.length: cast in progress, cast_progress icons should be fully visible
var cast_progress: int = 0
const empty_arrow_icons = {
	ComplexityCalculator.Direction.RIGHT: preload("res://icons/gravity-ui--arrow-shape-right.png"),
	ComplexityCalculator.Direction.UP: preload("res://icons/gravity-ui--arrow-shape-up.png"),
	ComplexityCalculator.Direction.DOWN: preload("res://icons/gravity-ui--arrow-shape-down.png"),
	ComplexityCalculator.Direction.LEFT: preload("res://icons/gravity-ui--arrow-shape-left.png"),
}

func _init(spell: BaseSpell, input: Array[ComplexityCalculator.Direction]) -> void:
	spell_name = spell.spell_name
	spell_icon = spell.icon_texture
	spell_input = input

# Mostly just set up the arrows 
func _ready() -> void:
	for dir in spell_input:
		var dir_icon = TextureRect.new()
		dir_icon.texture = empty_arrow_icons[dir]
		dir_icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		dir_icon.stretch_mode = TextureRect.STRETCH_SCALE
		$HBoxContainer/VBoxContainer/ArrowArray.add_child(dir_icon)
	
## Returns true if the input is correct for the next step
func pass_input(input: ComplexityCalculator.Direction) -> bool:
	if cast_progress == -1 or spell_input[cast_progress] != input:
		cast_progress = -1
		return false
	cast_progress += 1
	return true

## Reset the card to a fresh state
func reset_cast() -> void:
	cast_progress = 0
	
func _update_icons():
	if cast_progress == 0:
		for texture_child in $HBoxContainer/VBoxContainer/ArrowArray.get_children():
			# Reset to full opacity
			pass
	if cast_progress == -1: 
		for texture_child in $HBoxContainer/VBoxContainer/ArrowArray.get_children():
			# super-fade, spell invalid
			pass
	else:
		# Highlight inputs that have been successfully cast so far
		for i in range($HBoxContainer/VBoxContainer/ArrowArray.get_children().size()):
			var current_arrow = $HBoxContainer/VBoxContainer/ArrowArray.get_child(i)
			if i < cast_progress:
				pass
				# highlight section of successfuly cast spell
			else:
				# slightly fade rest of the spell
				pass 
