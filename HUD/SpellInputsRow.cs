using Godot;
using System;
using System.Collections.Generic;
using System.Linq;
using ddrcast;
using ddrcast.HUD;

public partial class SpellInputsRow : HBoxContainer
{
    public IList<Direction> InputsDirection
    {
        get => GetChildren().Select(icon => ((ArrowIcon)icon).Direction).ToList();
        set
        {
            foreach (var child in GetChildren())
            {
                child.QueueFree();
            }

            foreach (var direction in value)
            {
                AddChild(ArrowIcon.DirectionToIcon(direction));
            }
        }
    }
    
    /// <param name="direction">The direction to add</param>
    /// <param name="index">Where the direction should be inserted, negative indexes permitted.
    /// Adds to the end of the list by default</param>
    /// <returns>The number of elements in the list after addition</returns>
    public int AddInput(Direction direction, int index = -1)
    {
        AddChild(ArrowIcon.DirectionToIcon(direction));
        return GetChildren().Count;
    }
    
    /// <param name="index">Which element to remove, can use negative indexes. Removes the last by default</param>
    /// <returns>The number of elements after removal</returns>
    public int RemoveInput(int index = -1)
    {
        GetChild(index).QueueFree();
        return GetChildren().Count;
    }
}
