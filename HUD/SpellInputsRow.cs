using System.Linq;
using Godot;
using Godot.Collections;

namespace ddrcast.HUD;

[Tool]
public partial class SpellInputsRow : HBoxContainer
{
    [Export]
    public Array<Direction> InputsDirection
    {
        get => new(GetChildren().Select(icon => ((ArrowIcon)icon).Direction));
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
        var arrowIcon = ArrowIcon.DirectionToIcon(direction);
        AddChild(arrowIcon);
        MoveChild(arrowIcon, index);
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