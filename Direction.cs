using Godot;

namespace ddrcast;

public enum Direction
{
    // four basic directions
    Up,
    Down,
    Left,
    Right,
    // four additional directions if 6-dir is ever used
    UpLeft,
    UpRight,
    DownLeft,
    DownRight,
}

static class DirectionUtils
{
    /// <summary>
    /// 
    /// </summary>
    /// <param name="event">An input event that needs to be translated to a spell direction</param>
    /// <param name="isReleased"></param>
    /// <returns>The spell direction associated with this input event, or null if this event is not associated with one</returns>
    public static Direction? FromInputEvent(InputEvent @event, bool isReleased = false)
    {
        // True because hex directions not worked on yet
        // This would be changed to check if hex directions are in use
        // oh shoot or maybe even octal directions
        if (true)
        {
            if (@event.IsActionPressed("spell_input_down"))
                return Direction.Down;
            if (@event.IsActionPressed("spell_input_up"))
                return Direction.Up;
            if (@event.IsActionPressed("spell_input_left"))
                return Direction.Left;
            if (@event.IsActionPressed("spell_input_right"))
                return Direction.Right;
        }
        else
        {
            // Hex directions
            
        }
        return null;
    }
}