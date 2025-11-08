class_name SpellCard extends Control

@export var spell_name: String = "Placeholder spell"
@export var spell_icon: Texture = preload("res://HUD/icons/triangle_warning.png")
@export var spell_input: Array[ComplexityCalculator.Direction] = []

enum CastState {IDLE, IN_PROGRESS, COMPLETED, FAILED}

signal spell_completed(complexity: float)
signal spell_failed(inputs_so_far: Array[ComplexityCalculator.Direction])

## If cast_progress is 0, a cast has not been started and all icons should be clear
## cast_progress == -1: cast in progress, but it's invalid for this spell. Full card gray
## cast_progress > 0 and < spell_input.length: cast in progress, cast_progress icons should be fully visible
var cast_progress: Array[ComplexityCalculator.Direction] = []
var cast_state: CastState = CastState.IDLE
const empty_arrow_icons: Dictionary[Variant, Variant] = {
	ComplexityCalculator.Direction.RIGHT: preload("res://HUD/icons/arrow_outline_right.png"),
	ComplexityCalculator.Direction.UP: preload("res://HUD/icons/arrow_outline_up.png"),
	ComplexityCalculator.Direction.DOWN: preload("res://HUD/icons/arrow_outline_down.png"),
	ComplexityCalculator.Direction.LEFT: preload("res://HUD/icons/arrow_outline_left.png"),
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
	if cast_state == CastState.FAILED:
		return false
	elif spell_input[cast_progress.size()] != input:
		cast_state = CastState.FAILED
		spell_failed.emit(cast_progress)
		cast_progress = []
		return false
	else:
		cast_progress.append(input)
		return true

## Reset the card to a fresh state
func reset_cast() -> void:
	cast_progress = []
	cast_state = CastState.IDLE

func _update_icons():
	if cast_state == CastState.IDLE:
		for texture_child in $HBoxContainer/VBoxContainer/ArrowArray.get_children():
			# Reset to full opacity
			pass
	if cast_state == CastState.FAILED:
		for texture_child in $HBoxContainer/VBoxContainer/ArrowArray.get_children():
			# super-fade, spell invalid
			pass
	else:
		# Highlight inputs that have been successfully cast so far
		for i in range($HBoxContainer/VBoxContainer/ArrowArray.get_children().size()):
			var current_arrow = $HBoxContainer/VBoxContainer/ArrowArray.get_child(i)
			if i < cast_progress.size():
				pass
				# highlight section of successfuly cast spell
			else:
				# slightly fade rest of the spell
				pass
