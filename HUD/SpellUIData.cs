using System.Collections.Generic;
using Godot;

namespace ddrcast.HUD;

public record SpellUiData
{
    private static readonly Texture2D PlaceholderTexture = GD.Load<Texture2D>("res://HUD/icons/triangle_warning.png");
    
    public Texture2D FullTexture;
    public Texture2D IconTexture;
    public string SpellName;
    public int SpellId;
    
    public static List<SpellUiData> PlaceholderSpells =
    [
        new SpellUiData { FullTexture = PlaceholderTexture, IconTexture = PlaceholderTexture, SpellName = "placeholder1", SpellId = 0 },
        new SpellUiData { FullTexture = PlaceholderTexture, IconTexture = PlaceholderTexture, SpellName = "placeholder2", SpellId = 1 },
        new SpellUiData { FullTexture = PlaceholderTexture, IconTexture = PlaceholderTexture, SpellName = "placeholderReallyReallyReallyReallyReallyReallyLong", SpellId = 2 },
        new SpellUiData { FullTexture = PlaceholderTexture, IconTexture = PlaceholderTexture, SpellName = "short", SpellId = 3 }
    ];
}