extends PanelContainer

var prepared_spells: Array[BaseSpell] = []:
	set(new_spell_list):
		prepared_spells = new_spell_list
		
@onready var spell_cards_list = $Spellcards

func add_spell(spell: BaseSpell):
	prepared_spells.append(spell)
	
