@abstract class_name BaseSpell extends Node

var icon_texture: Texture = preload("res://icons/gravity-ui--triangle-exclamation.png")
var spell_name: String = "Spell placeholder"

## Emitted when this spell is cast
signal spell_started(spell: BaseSpell, complexity: float)
## Emitted when this spell finishes (meaning 
signal spell_finished(spell: BaseSpell, complexity: BaseSpell, time_taken_sec: float)
## Emitted when the spell is ready to go on cooldown. This will usually be when the spell is cast, but
## some may prefer to start their cooldown when the effect ends
signal spell_cooldown_start(spell: BaseSpell, complexity: float)

func cast_spell(complexity: float):
	spell_started.emit(self, complexity)
	
	
	spell_finished.emit(self, complexity)
	
## The actual effect of the spell
@abstract
func _spell_effect(complexity: float)
