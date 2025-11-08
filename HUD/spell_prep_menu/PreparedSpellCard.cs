using System.Collections.Generic;
using Godot;

namespace ddrcast.HUD.spell_prep_menu;

public partial class PreparedSpellCard : Control
{
	private HBoxContainer _arrowHbox;
	private List<Direction> _arrowDirections = new();

	public List<Direction> ArrowDirections
	{
		get => _arrowDirections;
		set
		{
			_arrowDirections = value;
			foreach (var icon in ArrowIcon.DirectionsToIcons(value))
			{
				_arrowHbox.AddChild(icon);
			}
		}
	}

	public override void _Ready()
	{
		_arrowHbox = GetNode<HBoxContainer>("SpellInputs");
	}
}