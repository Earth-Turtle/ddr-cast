extends PanelContainer

var prepared_spells: Array[BaseSpell] = []:
	set(new_spell_list):
		prepared_spells = new_spell_list
		
@onready var spell_cards_list = $Spellcards

signal spell_added(spell: BaseSpell, spell_input: SpellInput)
signal spell_removed(spell: BaseSpell, spell_input: SpellInput)

func add_spell(spell: BaseSpell):
	prepared_spells.append(spell)
	
