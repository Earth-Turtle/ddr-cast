using Godot;
using GodotOnReady.Attributes;

namespace ddrcast.HUD.spell_prep_menu;

public partial class SpellPrepMenu : Control
{
	[OnReadyGet("OuterBorder/HBoxContainer/PendingInputsBackground/CenterContainer/SpellInputs")] private SpellInputsRow _spellInputsRow;
	[OnReadyGet("OuterBorder/HBoxContainer/PreparedSpellsBackground/PreparedSpells")] private VBoxContainer _preparedSpells;

	public override void _GuiInput(InputEvent @event)
	{
		if (@event.IsAction("ui_accept"))
		{
			// Consume the arrows in the prep area and add them to the left
			var inputs = _spellInputsRow?.InputsDirection;
			var preparedSpellCard = new PreparedSpellCard();
			preparedSpellCard.SpellChoices= SpellUiData.PlaceholderSpells;
			preparedSpellCard.ArrowDirections = inputs;
			_preparedSpells.AddChild(preparedSpellCard);
			return;
		}

		if (@event.IsAction("ui_cancel"))
		{
			// Remove the last arrow in the prep area
			_spellInputsRow?.RemoveInput();
			return;
		}
		
		var dir = DirectionUtils.FromInputEvent(@event);
		if (dir is not null)
		{
			// spell input, add to list
			_spellInputsRow?.AddInput(dir.Value);
		}

		// Unrecognized, do nothing
	}
}