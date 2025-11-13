using System;
using System.Collections.Generic;
using System.Linq;
using Godot;
using GodotOnReady.Attributes;

namespace ddrcast.HUD.spell_prep_menu;

[Tool]
public partial class PreparedSpellCard : Control
{
    [OnReadyGet("SpellInputs")] private HBoxContainer _arrowHBox;
    [OnReadyGet("HBoxContainer/SpellSelection")] private OptionButton _spellSelection;
    private IList<SpellUiData> _spellChoices = new List<SpellUiData>();
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

    public IList<Direction> ArrowDirections
    {
        get => _arrowHBox?.GetChildren().Select(node => ((ArrowIcon)node).Direction).ToList().AsReadOnly();
        set
        {
            foreach (var child in _arrowHBox?.GetChildren()!)
            {
                child.QueueFree();
            }

            foreach (var icon in ArrowIcon.DirectionsToIcons(value))
            {
                _arrowHBox?.AddChild(icon);
            }
        }
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
    private void AttachOptionSignal()
    {
        _spellSelection.ItemSelected += index => SpellSelected?.Invoke(this, _spellChoices[(int)index]);
    }

    public void AddArrow(Direction direction)
    {
        _arrowHBox?.AddChild(ArrowIcon.DirectionToIcon(direction));
    }

    public void RemoveLastArrow()
    {
        _arrowHBox?.GetChild(-1).QueueFree();
    }
}