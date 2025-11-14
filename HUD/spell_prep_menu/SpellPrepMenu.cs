using Godot;

namespace ddrcast.HUD.spell_prep_menu;

public partial class SpellPrepMenu : Control
{
	private static readonly PackedScene SpellCardScene = GD.Load<PackedScene>("res://HUD/spell_prep_menu/prepared_spell_card.tscn");
	
	[Export] public SpellInputsRow SpellInputsRow;
	[Export] public VBoxContainer PreparedSpells;
	
	public override void _Input(InputEvent @event)
	{
		if (@event.IsActionPressed("ui_accept"))
		{
			// Consume the arrows in the prep area and add them to the left
			var inputs = SpellInputsRow?.InputsDirection;
			var preparedSpellCard = SpellCardScene.Instantiate<PreparedSpellCard>();
			PreparedSpells.AddChild(preparedSpellCard);
			preparedSpellCard.SpellChoices = SpellUiData.PlaceholderSpells;
			preparedSpellCard.ArrowDirections = inputs;
			return;
		}

		if (@event.IsActionPressed("ui_cancel"))
		{
			// Remove the last arrow in the prep area
			SpellInputsRow?.RemoveInput();
			return;
		}
		
		var dir = DirectionUtils.FromInputEvent(@event);
		if (dir is not null)
		{
			// spell input, add to list
			SpellInputsRow?.AddInput(dir.Value);
		}

		// Unrecognized, do nothing
	}
}