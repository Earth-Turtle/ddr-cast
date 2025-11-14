using System;
using System.Collections.Generic;
using Godot;
using Godot.Collections;

namespace ddrcast.HUD.spell_prep_menu;

[Tool]
public partial class PreparedSpellCard : Control
{
    [Export] public SpellInputsRow SpellInputs;
    [Export] public OptionButton SpellSelection;
    [Export] public Button RemoveButton;
    
    // Temporary until I get spell selection loaded or w/e
    private IList<SpellUiData> _spellChoices = SpellUiData.PlaceholderSpells;
    public event EventHandler<SpellUiData> SpellSelected;

    public IList<SpellUiData> SpellChoices
    {
        get => _spellChoices.AsReadOnly();
        set
        {
            _spellChoices = value;
            foreach (var spellUiData in value)
            {
                SpellSelection.AddIconItem(spellUiData.IconTexture, spellUiData.SpellName);
            }
        }
    }

    [Export]
    public Array<Direction> ArrowDirections
    {
        get => SpellInputs?.InputsDirection;
        set
        {
            if (SpellInputs != null) SpellInputs.InputsDirection = value;
        }
    }

    public override void _Ready()
    {
        foreach (var spellUiData in _spellChoices)
        {
            SpellSelection.AddIconItem(spellUiData.IconTexture, spellUiData.SpellName, spellUiData.SpellId);
        }
        
        SpellSelection.ItemSelected += index => SpellSelected?.Invoke(this, _spellChoices[(int)index]);
        RemoveButton.ButtonUp += QueueFree;
    }

    public void AddArrow(Direction direction, int index = -1)
    {
        SpellInputs?.AddInput(direction, index);
    }

    public void RemoveArrow(int index = -1)
    {
        SpellInputs?.RemoveInput(index);
    }
}