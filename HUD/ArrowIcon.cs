using System.Collections.Generic;
using System.Linq;
using Godot;

namespace ddrcast.HUD;

[Tool]
public partial class ArrowIcon : TextureRect
{
	private static readonly Texture2D LeftTexture = GD.Load<Texture2D>("res://HUD/icons/arrow_outline_left.png");
	private static readonly Texture2D RightTexture = GD.Load<Texture2D>("res://HUD/icons/arrow_outline_right.png");
	private static readonly Texture2D UpTexture = GD.Load<Texture2D>("res://HUD/icons/arrow_outline_up.png");
	private static readonly Texture2D DownTexture = GD.Load<Texture2D>("res://HUD/icons/arrow_outline_down.png");
	private static readonly Texture2D PlaceholderTexture = GD.Load<Texture2D>("res://HUD/icons/triangle_warning.png");
	
	
	private Direction _direction = Direction.Right;
	[Export]
	public Direction Direction
	{
		get => _direction;
		set
		{
			_direction = value;
			switch (value)
			{
				case Direction.Up:
					Texture = UpTexture;
					break;
				case Direction.Left:
					Texture = LeftTexture;
					break;
				case Direction.Down:
					Texture = DownTexture;
					break;
				case Direction.Right:
					Texture = RightTexture;
					break;
				default:
					GD.PushWarning("Non-orthogonal directions not ready yet");
					Texture = PlaceholderTexture;
					break;
			}
		}
	}

	public static ArrowIcon DirectionToIcon(Direction direction)
	{
		var icon = new ArrowIcon();
		icon.Direction = direction;
		return icon;
	}

	public static IReadOnlyList<ArrowIcon> DirectionsToIcons(IEnumerable<Direction> directions)
	{
		return directions.Select(DirectionToIcon).ToList();
	}
}