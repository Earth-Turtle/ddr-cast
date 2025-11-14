using System;
using System.Collections.Generic;
using Godot;
using Godot.Collections;
using GodotOnReady.Attributes;

namespace ddrcast.HUD.spell_prep_menu;

[Tool]
public partial class PreparedSpellCard : Control
{
    [OnReadyGet("SpellInputs")] private SpellInputsRow _spellInputs;
    [OnReadyGet("HBoxContainer/SpellSelection")] private OptionButton _spellSelection;
    [OnReadyGet("HBoxContainer/RemoveButton")] private Button _removeButton;
    
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
                _spellSelection?.AddIconItem(spellUiData.IconTexture, spellUiData.SpellName);
            }
        }
    }

    [Export]
    public Array<Direction> ArrowDirections
    {
        get => _spellInputs?.InputsDirection;
        set => _spellInputs.InputsDirection = value;
    }

    [OnReady]
    private void FillChoices()
    {
        foreach (var spellUiData in _spellChoices)
        {
            _spellSelection?.AddIconItem(spellUiData.IconTexture, spellUiData.SpellName, spellUiData.SpellId);
        }
    }

    [OnReady]
    private void AttachButtonSignals()
    {
        _spellSelection.ItemSelected += index => SpellSelected?.Invoke(this, _spellChoices[(int)index]);
        _removeButton.ButtonUp += QueueFree;
    }

    public void AddArrow(Direction direction, int index = -1)
    {
        _spellInputs?.AddInput(direction, index);
    }

    public void RemoveArrow(int index = -1)
    {
        _spellInputs?.RemoveInput(index);
    }
}